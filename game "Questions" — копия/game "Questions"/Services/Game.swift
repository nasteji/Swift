//
//  Game.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 13.07.2021.
//

import Foundation

final class Game {

    static let shared = Game()
    
    private(set) var results: [Result] {
        didSet {
            resultsCareTaker.saveResults(results: results)
        }
    }

    private let resultsCareTaker = CareTaker()
   
    var gameSession: GameSession?
    
    internal init(results: [Result]) {
        self.results = results
    }
    
    private init() {
        results = resultsCareTaker.loadResults() ?? []
    }
    
    func percentOfCorrectAnswers() -> String {
        if let session = gameSession {
            let result = (session.correctAnswers * 100) / session.questionsCount
            return "\(result) %"
        } else {
            return ""
        }
    }
    
    func addResult() {
        let result = Result(date: Date(), result: percentOfCorrectAnswers())
        results.append(result)
    }
    
    func clearResult() {
        results.removeAll()
    }
    
}
