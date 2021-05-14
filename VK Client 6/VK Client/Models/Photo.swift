//
//  Photo.swift
//  VK Client
//
//  Created by Анастасия Живаева on 16.04.2021.
//

import Foundation
import RealmSwift

struct Album: Codable {
    let response: AlbumResponse
}
struct AlbumResponse: Codable {
    let count: Int
    let items: [Photo]
}
class Photo: Object, Codable {
    @objc dynamic var owner: Int
    @objc dynamic var sizes: [Sizes]
    
    enum CodingKeys: String, CodingKey {
        case sizes
        case owner = "owner_id"
    }
}
class Sizes: Object, Codable {
    @objc dynamic var url: String
}
