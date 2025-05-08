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
    
    @Published var gameOver: Bool = false
    @Published var timeRemaining: Int = 30
    var gameTimer: GameTimer!
    
    private var currentLevelIndex: Int {
        UserDefaults.standard.integer(forKey: KeysManager.userDefaultsLevelKey)
    }

    init() {
        gameTimer = GameTimer(totalTime: 30) { [weak self] in
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
    
    private func getQuestion() -> MathProblem? {
        let difficulty = difficultyForCurrentLevel(for: currentLevelIndex)
        
        let availableQuestions = mathProblems.filter {
            $0.difficulty == difficulty && !usedQuestions.contains($0)
        }
        
        if let nextQuestion = availableQuestions.randomElement() {
            usedQuestions.append(nextQuestion)
            return nextQuestion
        }
        
        usedQuestions.removeAll()
        
        return mathProblems.filter { $0.difficulty == difficulty }.randomElement()
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
            gameName: "MathGame",
            category: Category.LogicalThinking.rawValue,
            score: scoreDouble
        )
    }
}

