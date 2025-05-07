//
//  MathViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import Foundation

class MathViewModel: ObservableObject {
    @Published var currentQuestion: MathProblem?
    @Published var usedQuestions: [MathProblem] = []
    @Published var round: Int = 0
    @Published var correctAnswers: Int = 0
    @Published var startTime: Date?
    @Published var endTime: Date?
    @Published var duration: TimeInterval?
    @Published var speedMultiplier: Double = 1.0
    @Published var finalScore: Double = 0.0

    init() {
        startTime = Date()
        getNextQuestion()
    }
    
    func getNextQuestion() {
        if let nextQuestion = getQuestion() {
            currentQuestion = nextQuestion
        }
    }
    
    private func getQuestion() -> MathProblem? {
        let availableQuestions = mathProblems.filter { question in
            !usedQuestions.contains(where: { $0 == question })
        }
        
        if let nextQuestion = availableQuestions.randomElement() {
            usedQuestions.append(nextQuestion)
            return nextQuestion
        }
        
        usedQuestions.removeAll()
        
        return mathProblems.randomElement()
    }
    
    func playAgain() {
        round = 0
        correctAnswers = 0
        startTime = Date()
        getNextQuestion()
    }
    
    func calculateFinalScore() {
        endTime = Date()
        if let start = startTime, let end = endTime {
            let duration = end.timeIntervalSince(start)
            speedMultiplier = max(1.0, 120.0 / duration)
            finalScore = (Double(correctAnswers)/10)*speedMultiplier
        }
    }
}

