//
//  Result.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 13.07.2021.
//

import Foundation

class Result: Codable {
    let date: Date
    let result: String
    
    init(date: Date, result: String) {
        self.date = date
        self.result = result
    }
}
