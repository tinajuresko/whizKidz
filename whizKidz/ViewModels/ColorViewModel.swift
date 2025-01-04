//
//  ColorViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import Foundation

class ColorViewModel: ObservableObject {
    @Published var cards: [MemoryCard] = []
    @Published var flippedCards: [MemoryCard] = []
    @Published var score: Int = 0
        
    init() {
        resetGame()
    }
    
    func resetGame() {
        let colors = ColorChoice.allCases
        let shuffledColors = (colors + colors).shuffled() // duplicate colors for pairs
        cards = shuffledColors.map { MemoryCard(color: $0) }
        score = 0
    }
    
    func flipCard(card: MemoryCard) {
        if flippedCards.count == 2 {
            return
        }
        
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isFlipped = true
            flippedCards.append(cards[index])
        }
            
        if flippedCards.count == 2 {
            checkMatch()
        }
    }
    
    func checkMatch() {
        if flippedCards[0].color == flippedCards[1].color {
            score += 1
            flippedCards.removeAll()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.flipBackCards()
            }
        }
    }
    
    func flipBackCards() {
        if let index1 = cards.firstIndex(where: { $0.id == flippedCards[0].id }),
           let index2 = cards.firstIndex(where: { $0.id == flippedCards[1].id }) {
            cards[index1].isFlipped = false
            cards[index2].isFlipped = false
        }
        flippedCards.removeAll()
    }
}
