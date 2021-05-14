//
//  Avatar.swift
//  VK Client
//
//  Created by Анастасия Живаева on 07.03.2021.
//

import UIKit

@IBDesignable
class AvatarView: UIView {
    
    var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    @IBInspectable
    var placeholderColor: UIColor = .lightGray {
        didSet {
            imageView.layer.backgroundColor = placeholderColor.cgColor
        }
    }
    @IBInspectable
    var placeholderTintColor: UIColor = .white {
        didSet {
            imageView.tintColor = placeholderTintColor
        }
    }
    
    private var shadowView: UIView!
    
    private var button: UIButton!
    
    @IBInspectable
    var shadowColor: UIColor = UIColor.white {
        didSet {
            shadowView.layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable
    var shadowOpacity: Float = 1 {
        didSet {
            shadowView.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat = 5 {
        didSet {
            shadowView.layer.shadowRadius = CGFloat(shadowRadius)
        }
    }
    @IBInspectable
    var shadowOffset: CGSize = CGSize(width: 4, height: 4) {
        didSet {
            shadowView.layer.shadowOffset = shadowOffset
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupShadow()
        setupImage()
        setupButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupShadow()
        setupImage()
        setupButton()
    }
    
    private func setupImage() {
        imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = bounds.width / 2
        imageView.layer.backgroundColor = placeholderColor.cgColor
        imageView.tintColor = placeholderTintColor
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
    }
    private func setupShadow() {
        
        shadowView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOffset = shadowOffset
        
        let radius = bounds.width / 2
        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: radius, height: radius)).cgPath
        shadowView.layer.shadowPath = cgPath
        
        addSubview(shadowView)
    }
    private func setupButton() {
        button = UIButton(type: .system)
        addSubview(button)
        button.addTarget(self, action: #selector(buttonTappedAnimate), for: .touchUpInside)
    }
    
    @objc private func buttonTappedAnimate(_ sender: UIButton) {
        self.shadowView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 3,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 2,
                       options: [],
                       animations: {
                        self.imageView.transform = CGAffineTransform.identity
                        self.shadowView.transform = CGAffineTransform.identity
                       },
                       completion: { (finished) in
                        
                        UIView.animate(withDuration: 0.6,
                                       animations: {
                            self.shadowView.alpha = 0.7
                            self.shadowView.transform = CGAffineTransform(scaleX: 10, y: 2)
                        })
                        UIView.animate(withDuration: 0.6,
                                       delay: 0.6,
                                       options: [],
                                       animations: {
                            self.shadowView.alpha = 1
                            self.shadowView.transform = CGAffineTransform.identity
                        }, completion: nil)
                       })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        button.frame = bounds
    }
    
}
