//
//  MyFriendsViewController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import SwiftUI
import RealmSwift

class MyFriendsViewController: UITableViewController {
    
    var users = [User]()
    
    var usersDictionary = [String: [User]]()
    var objectArray = [Objects]()
    
    var token = NotificationToken()
    let service = PromiseService()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFriends()
        
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: ListCell.reuseID)

        let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: CustomHeaderView.reuseID)
    }

    // MARK: - Service
    
    func loadFriends() {
        service.getUrl()
            .then(on: DispatchQueue.global(), service.getData(_:))
            .then(service.getParsedData(_:))
            .done(on: DispatchQueue.main) { users in
                self.loadData()
                self.readData()
            }
            .catch { error in
                print(error)
            }
    }
    
    // MARK: - Load and Read Data
    
    func loadData() {
        do {
            let realm = try Realm()
            let users = realm.objects(User.self)
            self.users = Array(users)
        } catch {
            print(error)
        }
        
        self.usersDictionary = User.dictionary(users: users)
        
        for (key, value) in self.usersDictionary {
            self.objectArray.append(Objects(sectionName: key, sectionObjects: value))
            self.objectArray.sort(by: { $0.sectionName.lowercased() < $1.sectionName.lowercased() } )
        }
        tableView.reloadData()
    }
    
    func readData() {
        guard let realm = try? Realm() else { return }
        let users = realm.objects(User.self)
        token = users.observe { changes in
            guard let tableView = self.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
                print("Start to modified Users")
            case .update(let results, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.endUpdates()
                print("Users were modified: \(results)")
            case .error(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.reuseID) as? CustomHeaderView
        else { return nil }

        headerView.label.text = objectArray[section].sectionName
        headerView.color(color: tableView.backgroundColor!, opacity: 0.6)

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CustomHeaderView.height
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return Array(usersDictionary.keys.sorted(by: { $0.lowercased() < $1.lowercased() }))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID, for: indexPath) as! ListCell
        
        let user = objectArray[indexPath.section].sectionObjects[indexPath.row]
        cell.configure(user: user)
        
        return cell
    }

    // MARK: - Segues
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "SegueToFriendsFotoController", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let controller = segue.destination as? FriendsFotoController,
           let indexPath = tableView.indexPathForSelectedRow {

            let user = objectArray[indexPath.section].sectionObjects[indexPath.row]

            controller.friendName = user.firstName + " " + user.lastName
            controller.id = user.id
        }
    }
    
}


