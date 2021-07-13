//
//  Question.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 10.07.2021.
//

import Foundation

class Question {
    
    let question: String
    let answers: [String]
    let correctAnswer: String
    
    init(question: String, answers: [String], correctAnswer: String) {
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
}

extension Question {
    static var question1 = Question(question:  "Змеи  видят даже через ...", answers: ["веки", "хвост", "рот", "облака"], correctAnswer: "веки")
    static var question2 = Question(question: "Крысы могут ...", answers: ["платить ипотеку", "смеяться от щекотки", "злиться", "плакать от горя"], correctAnswer: "смеяться от щекотки")
    static var question3 = Question(question: "Когда устрицам необходимо размножаться, они  могут ...", answers: ["красить губы", "менять свой пол", "преодолевать 1000км", "петь песни"], correctAnswer: "менять свой пол")
    static var question4 = Question(question: "Божьи Коровки могут ...", answers: ["убирать за собой еду", "играть в карты", "пылесосить", "кормить деток конфетками"], correctAnswer: "убирать за собой еду")
    static var question5 = Question(question: "Крокодилы не могут ...", answers: ["быстро бегать", "есть рыбу", "есть друг друга", "высовывать язык"], correctAnswer: "высовывать язык")
    
    static func fake() -> [Question] {
        [.question1, .question2, .question3, .question4, .question5]
    }
}
