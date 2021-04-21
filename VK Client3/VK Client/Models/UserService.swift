//
//  UserService.swift
//  VK Client
//
//  Created by Анастасия Живаева on 14.04.2021.
//

import Foundation
import Alamofire

class UserService {
    
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.130"
    
    func loadFriends(completion: @escaping ([User]) -> Void) {
        
        let path = "friends.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "fields": "photo_100",
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
                guard let data = response.value else { return }
                do {
                    let users = try JSONDecoder().decode(Friends.self, from: data)
                    completion(users.response.items)
                } catch {
                    print(error)
                }
        }
    }
    
    func loadUserPhotos(id: Int, completion: @escaping ([Photo]) -> Void) {
        let path = "photos.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "owner_id": id,
            "access_token": user.token,
            "photo_sizes": 1,
            "album_id": "profile",
            "v": version
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
                guard let data = response.value else { return }
                do {
                    let photos = try JSONDecoder().decode(Album.self, from: data)
                    completion(photos.response.items)
                } catch {
                    print(error)
                }
        }
    }
    
    func loadGroups(completion: @escaping ([Group]) -> Void) {
        let path = "groups.get?"
        let url = baseUrl+path
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "extended": 1,
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
    func searchByUserGroups(searchText: String, completion: @escaping ([Group]) -> Void) {
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
