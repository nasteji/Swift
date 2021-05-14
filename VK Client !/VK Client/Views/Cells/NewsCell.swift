//
//  NewsCell.swift
//  VK Client
//
//  Created by Анастасия Живаева on 19.03.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let reuseId = "NewsCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewAvatar: AvatarView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textNewsLabel: UILabel!
    @IBOutlet weak var imageNewsView: UIImageView!
    @IBOutlet weak var likeControl: ILikeButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(news: News) {
        nameLabel.text = news.sourceName
        dateLabel.text = news.date
        textNewsLabel.text = news.textNews
        imageNewsView.image = UIImage(named: news.imageNews)
        if let image = news.sourceImage {
            imageViewAvatar.image = UIImage(named: image)
        } else {
            imageViewAvatar.image = UIImage(systemName: "person.3.fill")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
