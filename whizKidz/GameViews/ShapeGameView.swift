//
//  ShapeGameView.swift
//  whizKidz
//
//  Created by Tina Jureško on 24.02.2025..
//

import SwiftUI
import SpriteKit

struct ShapeGameView: View {
    @StateObject private var viewModel = ShapeGameViewModel()
    
    var body: some View {
        ZStack {
            SpriteView(scene: makeScene())
                .ignoresSafeArea()
            
            if viewModel.isGameOver {
                VStack {
                    Text("Game Over")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text("Score: \(viewModel.correctClicks)")
                        .foregroundColor(.white)
                    Button("Play Again") {
                        viewModel.restartGame()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
            }
        }
        .onAppear {
            viewModel.startGame()
        }
    }
    
    func makeScene() -> SKScene {
        let scene = ShapeGameScene(viewModel: viewModel)
        scene.size = CGSize(width: 390, height: 844)
        scene.scaleMode = .fill
        return scene
    }
}

#Preview {
    ShapeGameView()
}
