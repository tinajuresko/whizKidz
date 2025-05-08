//
//  AlphabetViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 01.01.2025..
//

import Foundation

struct LetterImagePair: Hashable {
    var letter: String
    var image: String
}

class AlphabetViewModel: ObservableObject {
    @Published var currentRound: [(letter: String, image: String)] = []
    @Published var correctMatches: Int = 0
    @Published var correctLetters: Set<String> = []
    @Published var round: Int = 0
    @Published var shuffledLetters: [String] = []
    @Published var usedPairs: Set<LetterImagePair> = []
    
    @Published var score: Int = 0
    @Published var gameIsOver: Bool = false
    @Published var timeRemaining: Int = 60
    var gameTimer: GameTimer!
    
    private var currentLevelIndex: Int {
        UserDefaults.standard.integer(forKey: KeysManager.userDefaultsLevelKey)
    }
    
    init() {
        gameTimer = GameTimer(totalTime: 60) { [weak self] in
            self?.gameOver()
        }
        gameTimer.$timeRemaining
            .assign(to: &$timeRemaining)
        setTimeBasedOnLevel()
        gameTimer.start()
        startNewRound()
    }
    
    func setTimeBasedOnLevel() {
        let timeReductionFactor = 10
        let baseTime = 60
        let reducedTime = baseTime - (currentLevelIndex * timeReductionFactor)
        timeRemaining = max(reducedTime, 20)
    }
    
    func startNewRound() {
        
        if round >= 5 {
            gameOver()
            return
        }
        
        if usedPairs.count == alphabetGameData.count {
            usedPairs.removeAll()
        }
        round += 1
        currentRound = getRandomRound()
        shuffledLetters =  getShuffledLetters()
        correctMatches = 0
        correctLetters = []
    }
    
    func playAgain() {
        round = 0
        score = 0
        gameIsOver = false
        setTimeBasedOnLevel()
        gameTimer.start()
        startNewRound()
    }
    
    private func getRandomRound() -> [(letter: String, image: String)] {
        var newRound: [LetterImagePair] = []
        var usedLettersInRound: Set<String> = []
        var attempts = 0

        while newRound.count < 3 && attempts < 100 {
            let game = alphabetGameData.randomElement()!
            let image = game.images.randomElement()!
            let pair = LetterImagePair(letter: game.letter, image: image)

            if !usedPairs.contains(pair) && !usedLettersInRound.contains(pair.letter) {
                newRound.append(pair)
                usedPairs.insert(pair)
                usedLettersInRound.insert(pair.letter)
            }
            attempts += 1
        }

        return newRound.map { ($0.letter, $0.image) }
    }

    
    func checkMatch(letter: String, image: String) -> Bool {
        print("checking match")
        let pairToCheck = LetterImagePair(letter: letter, image: image)
        if let match = currentRound.first(where: { LetterImagePair(letter: $0.letter, image: $0.image) == pairToCheck }) {
            correctMatches += 1
            if correctMatches == 3 {
                score += 1
            }
            return true
        }
        return false
    }
    
    func getShuffledLetters () -> [String] {
        return currentRound.map { $0.letter }.shuffled()
    }
    
    func markCorrectLetters(letter: String) {
        correctLetters.insert(letter)
    }
    
    func gameOver() {
        gameTimer.stop()
        
        let scoreDouble = Double(score)
        guard let username = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey) else { return }
        
        DBManager.shared.saveGameStatistics(
            userId: username,
            gameName: "AlphabetGame",
            category: Category.LanguageUnderstanding.rawValue,
            score: scoreDouble
        )
        gameIsOver = true
    }
}
