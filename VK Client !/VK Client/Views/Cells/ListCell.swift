//
//  MyFriendsCell.swift
//  VK Client
//
//  Created by Анастасия Живаева on 12.03.2021.
//

import UIKit

class ListCell: UITableViewCell {
    
    static let reuseID = "Cell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewAvatar: AvatarView!
    
    func configure(user: User) {
        nameLabel.text = user.firstName + " " + user.lastName
        if let url = URL.init(string: user.photo) {
            let data = try? Data(contentsOf: url)
            imageViewAvatar.image = UIImage(data: data!)
        } else {
            imageViewAvatar.image = UIImage(systemName: "person.fill")
        }
    }
    func configure(group: Group) {
        nameLabel.text = group.name
        if let url = URL.init(string: group.photo) {
            let data = try? Data(contentsOf: url)
            imageViewAvatar.image = UIImage(data: data!)
        } else {
            imageViewAvatar.image = UIImage(systemName: "person.3.fill")
        }
    }
}
