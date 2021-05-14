//
//  UserService.swift
//  VK Client
//
//  Created by Анастасия Живаева on 14.04.2021.
//

import Foundation
import Alamofire
import RealmSwift

class UserService {
    
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.130"

    var config = Realm.Configuration()
    
    func loadFriends(completion: @escaping() -> Void) {
        
        let path = "friends.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "fields": "photo_100",
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData {
            [weak self] response in
                guard let data = response.value else { return }
                do {
                    let users = try JSONDecoder().decode(Friends.self, from: data)
                    self?.saveFriendsData(friends: users.response.items)
                    completion()
                } catch {
                    print(error)
                }
        }
    }
    func saveFriendsData(friends: [User]) {
        do {
            config.deleteRealmIfMigrationNeeded = true
            let realm = try Realm(configuration: config)
            print(realm.configuration.fileURL as Any)
           
            let oldFriends = realm.objects(User.self)
            realm.beginWrite()
            realm.delete(oldFriends)

            realm.add(friends)
            try realm.commitWrite()
            print(realm.objects(User.self))
        } catch {
            print(error)
        }
    }
    
    func loadUserPhotos(id: Int, completion: @escaping() -> Void) {
                     
        let path = "photos.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "owner_id": id,
            "access_token": user.token,
            "photo_sizes": 1,
            "album_id": "profile",
            "extended": 1,
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData {
            [weak self] response in
                guard let data = response.value else { return }
                do {
                    let photos = try JSONDecoder().decode(Album.self, from: data)
                    self?.savePhotosData(photo: photos.response.items)
                    completion()
                } catch {
                    print(error)
                }
        }
    }
    func savePhotosData(photo: [Photo]) {
        do {
            config.deleteRealmIfMigrationNeeded = true
            let realm = try Realm(configuration: config)
            
            let oldPhotos = realm.objects(Photo.self)
            realm.beginWrite()
            realm.delete(oldPhotos)

            realm.add(photo)
            try realm.commitWrite()
            print(realm.objects(Photo.self))
        } catch {
            print(error)
        }
    }
    
    func loadGroups(completion: @escaping() -> Void) {
        let path = "groups.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "extended": 1,
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData {
            [weak self] response in
                guard let data = response.value else { return }
                do {
                    let groups = try JSONDecoder().decode(GroupList.self, from: data)
                    self?.saveGroupsData(groups: groups.response.items)
                    completion()
                } catch {
                    print(error)
                }
        }
    }
    func saveGroupsData(groups: [Group]) {
        do {
            config.deleteRealmIfMigrationNeeded = true
            let realm = try Realm(configuration: config)
            
            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)

            realm.add(groups)
            try realm.commitWrite()
            print(realm.objects(Group.self))
        } catch {
            print(error)
        }
    }
    
    func searchByUserGroups(searchText: String, completion: @escaping([Group]) -> Void) {
        let path = "groups.search"
        let url = baseUrl+path
        let parameters: Parameters = [
            "q": searchText,
            "type": "group",
            "sort": 0,
            "access_token": user.token,
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
                guard let data = response.value else { return }
                do {
                    let groups = try JSONDecoder().decode(GroupList.self, from: data)
                    completion(groups.response.items)
                   
                } catch {
                    print(error)
                }
        }
    }
    
}
