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
    
    init() {
        startNewRound()
    }
    
    func startNewRound() {
        print("starting round")
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
}
