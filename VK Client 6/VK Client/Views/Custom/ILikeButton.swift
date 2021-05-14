//
//  ILikeIt.swift
//  VK Client
//
//  Created by Анастасия Живаева on 07.03.2021.
//

import UIKit

@IBDesignable
class ILikeButton: UIControl {

    var button: UIButton!
    
    var isOn: Bool = false {
        didSet {
            if isOn {
                button.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                button.tintColor = tintColorOnTap
                button.setTitle("1", for: .normal)
                button.setTitleColor(titleColorOnTap, for: .normal)
            } else {
                button.setTitle("0", for: .normal)
                button.setTitleColor(titleColorBegin, for: .normal)
                button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                button.tintColor = tintColorBegin
            }
        }
    }
    
    @IBInspectable
    var titleColorBegin: UIColor = .black {
        didSet {
            button.setTitleColor(titleColorBegin, for: .normal)
        }
    }
    @IBInspectable
    var tintColorBegin: UIColor = .black {
        didSet {
            button.tintColor = tintColorBegin
        }
    }
    @IBInspectable
    var tintColorOnTap: UIColor = .purple
    
    @IBInspectable
    var titleColorOnTap: UIColor = .purple
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        button = UIButton(type: .custom)
        
        button.setTitle("0", for: .normal)
        button.setTitleColor(titleColorBegin, for: .normal)
        button.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        button.tintColor = tintColorBegin

        
        addSubview(button)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        
        isOn.toggle()
        
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            self.button.frame.origin.y -= 50
            self.button.alpha = 0
        }, completion: { (finished) in
            
            UIView.animate(withDuration: 0,
                           animations: {
                            self.button.frame.origin.y += 50
                            self.button.alpha = 1
            })
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds
    }
}
