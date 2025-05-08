//
//  PuzzleViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 23.02.2025..
//

import Foundation

class PuzzleViewModel: ObservableObject {
    @Published var currentWord: Word
    @Published var chosenWords: [Word] = []
    @Published var selectedLetters: [String] = []
    @Published var scrambledLetters: [String] = []
    @Published var round: Int = 0
    @Published var score: Int = 0
    
    @Published var progress: Double = 0.0
    
    @Published var gameIsOver: Bool = false
    @Published var timeRemaining: Int = 45
    var gameTimer: GameTimer!
    
    private var currentLevelIndex: Int {
        UserDefaults.standard.integer(forKey: KeysManager.userDefaultsLevelKey)
    }
    
    init() {
        currentWord = Word(word: "", scrambledWord: [])
        gameTimer = GameTimer(totalTime: 45) { [weak self] in
            self?.gameOver()
        }
        gameTimer.$timeRemaining
            .assign(to: &$timeRemaining)
        setTimeBasedOnLevel()
        gameTimer.start()
        getNextWord()
    }
    
    func setTimeBasedOnLevel() {
        let timeReductionFactor = 10
        let baseTime = 60
        let reducedTime = baseTime - (currentLevelIndex * timeReductionFactor)
        timeRemaining = max(reducedTime, 20)
    }
    
    func playAgain() {
        gameIsOver = false
        score = 0
        currentWord = Word(word: "", scrambledWord: [])
        setTimeBasedOnLevel()
        gameTimer.start()
        
        getNextWord()
    }
    func getNextWord() {
        if let randomWord = words.randomElement() {
            if chosenWords.contains(where: {$0.id == randomWord.id}) {
                getNextWord()
            } else {
                chosenWords.append(randomWord)
                currentWord = randomWord
                scrambledLetters = currentWord.scrambledWord
                selectedLetters = []
            }
        }
        print(currentWord.scrambledWord)
    }
    
    func selectLetter(letter: String) { 
        if let index = scrambledLetters.firstIndex(of: letter) {
            scrambledLetters.remove(at: index)
            selectedLetters.append(letter)
            checkIfWordIsComplete()
        }
    }
    
    func removeSelectedLetter(at index: Int){
        let letter = selectedLetters.remove(at: index)
        scrambledLetters.append(letter)
    }
    
    func checkIfWordIsComplete() {
        if selectedLetters.joined() == currentWord.word {
            if round < 5 {
                round += 1
                progress += 0.2
                
                score += 1
                
                getNextWord()
            } else {
                gameOver()
            }
        }
    }
    
    func gameOver () {
        print("Game over")
        chosenWords.removeAll()
        selectedLetters.removeAll()
        round = 0
        progress = 0.0
        gameTimer.stop()
        gameIsOver = true
        
        let scoreDouble = Double(score)
        guard let username = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey) else { return }
        DBManager.shared.saveGameStatistics(
            userId: username,
            gameName: "PuzzleGame",
            category: Category.Memory.rawValue,
            score: scoreDouble
        )
        
        DBManager.shared.saveGameStatistics(
            userId: username,
            gameName: "PuzzleGame",
            category: Category.LanguageUnderstanding.rawValue,
            score: scoreDouble
        )
    }
}
