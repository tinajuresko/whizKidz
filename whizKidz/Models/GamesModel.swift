//
//  GamesModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 23.02.2025..
//

import Foundation
import SwiftUICore

struct Game: Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
    var text: String
    var view: AnyView
    var category: Category
}

let games: [Game] = [
    Game(name: "AlphabetGame", imageName: "alpha", text: "Learn Alphabet!", view: AnyView(AlphabetView()), category: .LanguageUnderstanding),
    Game(name: "MathGame", imageName: "math", text: "Learn Math!", view: AnyView(MathGameView()), category: .LogicalThinking),
    Game(name: "ColorGame", imageName: "colors", text: "Learn Colors!", view: AnyView(ColorGameView()), category: .Memory),
    Game(name: "PuzzleGame", imageName: "puzzle", text: "Find the Word!", view: AnyView(PuzzleGameView()), category: .Memory),
    Game(name: "ShapeGame", imageName: "shapes", text: "Learn Shapes!", view: AnyView(ShapeGameView()), category: .MotorSkills),
    Game(name: "HygieneGame", imageName: "hygiene", text: "Learn About Hygiene!", view: AnyView(HygieneGameView()), category: .LogicalThinking)
    
]
