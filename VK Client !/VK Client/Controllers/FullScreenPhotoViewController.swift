//
//  FullScreenPhotoViewController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 27.03.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, CAAnimationDelegate {
    
    var friendsImage: [Photo] = []
    var index: Int = 0

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var animator: UIViewPropertyAnimator!
    
    enum Direction {
        case left, right
        
        init(x: CGFloat) {
            self = x > 0 ? .right : .left
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL.init(string: (friendsImage[index].sizes.last!.url))
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        view.addGestureRecognizer(pan)
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        guard let panView = recognizer.view else { return }
        
        let translation = recognizer.translation(in: panView)
        let direction = Direction(x: translation.x)
        
        switch recognizer.state {
        case .began:
            animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut, animations: {
                self.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.imageView.alpha = 0
            })
            if canSlide(direction) {
                let nextIndex = direction == .left ? index + 1 : index - 1
                
                let urlNext = URL.init(string: (friendsImage[nextIndex].sizes.last!.url))
                let dataNext = try? Data(contentsOf: urlNext!)
                nextImageView.image = UIImage(data: dataNext!)
                
                view.addSubview(nextImageView)
                let offsetX = direction == .left ? view.bounds.width : -view.bounds.width
                nextImageView.frame = view.bounds.offsetBy(dx: offsetX, dy: 0)
                
                animator.addAnimations({
                    self.nextImageView.center = self.imageView.center
                    self.nextImageView.alpha = 1
                }, delayFactor: 0.2)
                
                animator.addCompletion { (position) in
                    guard position == .end else { return }
                    self.index = direction == .left ? self.index + 1 : self.index - 1
                    self.imageView.alpha = 1
                    self.imageView.transform = .identity
                    
                    let url = URL.init(string: (self.friendsImage[self.index].sizes.last!.url))
                    let data = try? Data(contentsOf: url!)
                    self.imageView.image = UIImage(data: data!)
            
                    self.nextImageView.removeFromSuperview()
                }
                animator.pauseAnimation()
            }
        case .changed:
            animator.fractionComplete = abs(translation.x) / panView.frame.width
        case .ended:
            if canSlide(direction), animator.fractionComplete > 0.33 {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            } else {
                animator.stopAnimation(true)
                UIView.animate(withDuration: 0.2, animations: {
                    self.imageView.transform = .identity
                    self.imageView.alpha = 1
                    let offsetX = direction == .left ? self.view.bounds.width : -self.view.bounds.width
                    self.nextImageView.frame = self.view.bounds.offsetBy(dx: offsetX, dy: 0)
                    self.nextImageView.transform = .identity
                })
            }
        default:
            break
        }
    }

    private func canSlide(_ direction: Direction) -> Bool {
        if direction == .left {
            return index < friendsImage.count - 1
        } else {
            return index > 0
        }
    }
    
}
