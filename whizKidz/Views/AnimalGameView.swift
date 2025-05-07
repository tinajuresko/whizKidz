//
//  AnimalGameView.swift
//  whizKidz
//
//  Created by Tina Jureško on 26.03.2025..
//

import SwiftUI

struct AnimalGameView: View {
    @State private var showModal: Bool = false
    @State private var showAlert = false
    @StateObject private var viewModel = AnimalViewModel()
    let speechManager = SpeechManager()
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                InfoButton(showAlert: $showAlert, instructions: "Click on the correct answers and fix the tooth. Each correct answer helps the tooth stop hurting and be clean and healthy, just like your teeth should be!🦷 \nClick on the musical note on the right to make brushing your teeth more fun! 🤪")
                
                
                
                VStack {
                    if let animal = viewModel.currentAnimal{
                        Image((animal.name).lowercased())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                    Button(action: {
                        speechManager.speak(viewModel.currentAnimal?.funFacts.randomElement() ?? "")
                    }) {
                        Text("Fun Fact")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
            }
            
            if showModal {
                GameOverModalView(
                    message: "Congratulations! You did great! 🏆",
                    onPlayAgain: {
                        showModal = false
                        viewModel.playAgain()
                    }
                )
                .transition(.scale)
                .animation(.easeInOut, value: showModal)
                .zIndex(1)
                    
            }
        }
        
       
    }
}

#Preview {
    AnimalGameView()
}
