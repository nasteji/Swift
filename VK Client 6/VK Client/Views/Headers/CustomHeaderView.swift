//
//  CustomHeaderView.swift
//  VK Client
//
//  Created by Анастасия Живаева on 18.03.2021.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {
    
    static let reuseID = "Header"
    static var height: CGFloat = 25

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var viewColor: UIView!

    func color(color: UIColor, opacity: CGFloat) {
        viewColor.backgroundColor = color
        viewColor.alpha = opacity
    }
}
