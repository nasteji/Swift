//
//  CareTaker.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 13.07.2021.
//

import Foundation

class CareTaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "key"
    
    func saveResults(results: [Result]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadResults() -> [Result]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try decoder.decode([Result].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
