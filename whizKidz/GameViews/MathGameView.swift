//
//  MathGameView.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import SwiftUI

struct MathGameView: View {
    @StateObject private var viewModel = MathViewModel()
    @State private var showModal: Bool = false
    @State private var showAlert = false
    
    @State private var plantStage: Int = 1
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    Button(action: {
                        showAlert.toggle()
                    }) {
                        Image(systemName: "questionmark.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Game Instructions"),
                            message: Text("Click on the correct answer to help the plant grow! Each correct answer will make the plant grow taller. Try to answer all the questions to see the plant fully grown!"),
                            dismissButton: .default(Text("Got it!")))
                    }
                    Spacer()
                }
                .padding([.top, .leading])
                
                Spacer()
                
                VStack {
                    Image("plant\(plantStage)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                        .transition(.scale)
                        .animation(.easeInOut, value: plantStage)
                    
                    if let question = viewModel.currentQuestion {
                        ProblemView(problem: question) { isCorrect in
                            if isCorrect {
                                withAnimation {
                                    plantStage = min(plantStage + 1, 5)
                                }
                                viewModel.correctAnswers += 1
                            }
                            viewModel.round += 1
                            if viewModel.round < 5 {
                                viewModel.getNextQuestion()
                            }else {
                                viewModel.calculateFinalScore()
                                showModal = true
                            }
                            
                        }
                    } else {
                        Text("All questions answered!")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }.offset(y: -150)
                
            }
            if showModal {
                GameOverModalView(
                    message: "Congratulations! You did great! 🏆",
                    onPlayAgain: {
                        showModal = false
                        plantStage = 1
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
    MathGameView()
}
