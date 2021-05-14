//
//  SearchGroupController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import RealmSwift

class SearchGroupController: UITableViewController, UISearchBarDelegate {
    
    var filteredGroups: [Group] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: ListCell.reuseID)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID, for: indexPath) as! ListCell
        
        let group = filteredGroups[indexPath.row]
        cell.configure(group: group)
        
        return cell
    }
    
    // MARK: - Search Bar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        userService.searchByUserGroups(searchText: searchText.lowercased()) { [weak self] groups in
//            self?.filteredGroups = groups
//        }
        userService.searchByUserGroups(searchText: searchText.lowercased()) { [weak self] in
            self?.loadData()
        }
        tableView.reloadData()
    }
    func loadData() {
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self)
            self.filteredGroups = Array(groups)
        } catch {
            print(error)
        }
    }
    
    
    
}
