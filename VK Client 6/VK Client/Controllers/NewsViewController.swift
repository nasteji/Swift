//
//  NewsViewController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 19.03.2021.
//

import UIKit

class NewsViewController: UITableViewController {

    var myNews = News.fake()
    var likeFlags: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.reuseId)
        
        likeFlags = myNews.map { _ in false }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as! NewsCell
        
        cell.configure(news: myNews[indexPath.row])
        cell.likeControl.isOn = likeFlags[indexPath.row]
        cell.sizeToFit()
        
        return cell
    }
    
}

