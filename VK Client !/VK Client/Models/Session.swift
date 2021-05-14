//
//  Session.swift
//  VK Client
//
//  Created by Анастасия Живаева on 08.04.2021.
//

import Foundation

final class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var token: String = ""
    var userId: String = ""
    
}
