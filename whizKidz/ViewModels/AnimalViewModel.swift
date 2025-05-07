//
//  AnimalViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 26.03.2025..
//

import Foundation

class AnimalViewModel: ObservableObject {
    @Published var currentAnimal: Animal?
    @Published var usedAnimals: [Animal] = []
    @Published var round: Int = 0
    
    init() {
        getNextAnimal()
    }
    
    func getNextAnimal() {
        if let nextAnimal = getAnimal() {
            currentAnimal = nextAnimal
        }
    }
    
    private func getAnimal() -> Animal? {
        let availableAnimals = animals.filter { animal in
                    !usedAnimals.contains(where: { $0 == animal })
        }
        
        if let nextAnimal = availableAnimals.randomElement() {
            usedAnimals.append(nextAnimal)
            return nextAnimal
        }
        
        usedAnimals.removeAll()
        
        return animals.randomElement()
    }
    
    func playAgain() {
        round = 0
        getNextAnimal()
    }
}
