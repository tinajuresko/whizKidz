//
//  HygieneViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 25.03.2025..
//

import Foundation

class HygieneViewModel: ObservableObject {
    @Published var currentQuestion: HygieneProblem?
    @Published var usedQuestions: [HygieneProblem] = []
    @Published var round: Int = 0
    @Published var correctAnswers: Int = 0
    
    @Published var gameOver: Bool = false
    @Published var timeRemaining: Int = 60
    var gameTimer: GameTimer!
    
    init() {
        gameTimer = GameTimer(totalTime: 60) { [weak self] in
            self?.endGame()
        }
        gameTimer.$timeRemaining
            .assign(to: &$timeRemaining)
        gameTimer.start()
        getNextQuestion()
    }
    
    func getNextQuestion() {
        if let nextQuestion = getQuestion() {
            currentQuestion = nextQuestion
        }
    }
    
    private func getQuestion() -> HygieneProblem? {
        let availableQuestions = hygieneProblems.filter { question in
                    !usedQuestions.contains(where: { $0 == question })
                }
        
        if let nextQuestion = availableQuestions.randomElement() {
            usedQuestions.append(nextQuestion)
            return nextQuestion
        }
        
        usedQuestions.removeAll()
        
        return hygieneProblems.randomElement()
    }
    
    func playAgain() {
        round = 0
        correctAnswers = 0
        
        gameOver = false
        gameTimer.start()
        getNextQuestion()
    }
    
    func endGame() {
        gameOver = true
        gameTimer.stop()
        
        let scoreDouble = Double(correctAnswers)
        guard let username = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey) else { return }
        DBManager.shared.saveGameStatistics(
            userId: username,
            gameName: "HygieneGame",
            category: Category.LogicalThinking.rawValue,
            score: scoreDouble
        )
    }
}
