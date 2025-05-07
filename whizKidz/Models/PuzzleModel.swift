//
//  PuzzleModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 23.02.2025..
//

import Foundation

struct Word: Identifiable {
    let id = UUID()
    let word: String
    let scrambledWord: [String]
}
extension String {
    func shuffledLetters() -> [String] {
        return Array(self).shuffled().map { String($0) }
    }
}


var words: [Word] = [
    Word(word: "apple", scrambledWord: "apple".shuffledLetters()),
    Word(word: "banana", scrambledWord: "banana".shuffledLetters()),
    Word(word: "orange", scrambledWord: "orange".shuffledLetters()),
    Word(word: "crayons", scrambledWord: "crayons".shuffledLetters()),
    Word(word: "cherry", scrambledWord: "cherry".shuffledLetters()),
    Word(word: "lemon", scrambledWord: "lemon".shuffledLetters()),
    Word(word: "strawberry", scrambledWord: "strawberry".shuffledLetters()),
    Word(word: "chocolate", scrambledWord: "chocolate".shuffledLetters()),
    Word(word: "kiwi", scrambledWord: "kiwi".shuffledLetters()),
    Word(word: "peach", scrambledWord: "peach".shuffledLetters()),
    Word(word: "policeman", scrambledWord: "policeman".shuffledLetters()),
    Word(word: "house", scrambledWord: "house".shuffledLetters()),
    Word(word: "horse", scrambledWord: "horse".shuffledLetters()),
    Word(word: "butterfly", scrambledWord: "butterfly".shuffledLetters()),
    Word(word: "teddy", scrambledWord: "teddy".shuffledLetters()),
    Word(word: "airplane", scrambledWord: "airplane".shuffledLetters()),
    Word(word: "teacher", scrambledWord: "teacher".shuffledLetters()),
    Word(word: "friend", scrambledWord: "friend".shuffledLetters()),
    Word(word: "grandmother", scrambledWord: "grandmother".shuffledLetters()),
    Word(word: "grandfather", scrambledWord: "grandfather".shuffledLetters())
]
