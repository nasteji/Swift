//
//  LoadingView.swift
//  VK Client
//
//  Created by Анастасия Живаева on 21.03.2021.
//

import UIKit

@IBDesignable
class LoadingView: UIView {

    private var imageViews: [UIImageView] = []
    private var stackView: UIStackView!
    
    var duration: Double = 0.5
    var tintImageColor: UIColor = .purple
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        animate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        animate()
    }
    
    private func setup() {
        
        for _ in 0...2 {
            let imageview = UIImageView(image: UIImage(systemName: "circle.fill"))
            imageview.layer.backgroundColor = UIColor.clear.cgColor
            imageview.tintColor = tintImageColor
            
            imageViews.append(imageview)
        }
        stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.spacing = 15
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        super.backgroundColor = .clear
        stackView.frame = bounds
    }
    
    private func animate() {
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.imageViews[0].alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: duration, delay: (duration / 3), options: [.repeat, .autoreverse], animations: {
            self.imageViews[1].alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: duration, delay: (2 * duration / 3), options: [.repeat, .autoreverse], animations: {
            self.imageViews[2].alpha = 0
        }, completion: nil)

    }
}

