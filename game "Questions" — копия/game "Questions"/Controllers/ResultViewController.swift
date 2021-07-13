//
//  ResultViewController.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 13.07.2021.
//

import UIKit

class ResultViewController: UITableViewController {
    
    @IBAction func clearButton(_ sender: UIButton) {
        Game.shared.clearResult()
        results = [Result]()
        tableView.reloadData()
    }
    
    var results = Game.shared.results
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell
        
        let result = results[indexPath.row]
        cell.dateLabel.text = dateFormatter.string(from: result.date)
        cell.resultLabel.text = result.result
        
        return cell
    }
    
}
