//
//  HygieneGameView.swift
//  whizKidz
//
//  Created by Tina Jureško on 25.03.2025..
//

import SwiftUI

struct HygieneGameView: View {
    @StateObject private var viewModel = HygieneViewModel()
    @State private var showModal: Bool = false
    @State private var showAlert = false
    @State private var toothStage: Int = 1
    
    let speechManager = SpeechManager()
    
    @State private var showVideo = false
    
    var body: some View {
        ZStack {
            Image("appBackground")
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
                            message: Text("Click on the correct answers and fix the tooth. Each correct answer helps the tooth stop hurting and be clean and healthy, just like your teeth should be!🦷 \nClick on the musical note on the right to make brushing your teeth more fun! 🤪"),
                            dismissButton: .default(Text("Got it!")))
                    }
                    
                    Image("music")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .onTapGesture {
                            showVideo = true
                        }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Time: \(viewModel.timeRemaining)s")
                            .font(.title3)
                            .foregroundColor(.red)
                        Text("Score: \(viewModel.correctAnswers)")
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                .padding([.top, .leading])
                .sheet(isPresented: $showVideo) {
                    VideoPopupView(showVideo: $showVideo)
                }
                
                Spacer()
                
                VStack {
                    Image("tooth\(toothStage)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                        .transition(.scale)
                        .animation(.easeInOut, value: toothStage)
                    
                    if let question = viewModel.currentQuestion {
                        ProblemView(problem: question) { isCorrect in
                            if isCorrect {
                                withAnimation {
                                    toothStage = min(toothStage + 1, 6)
                                }
                                viewModel.correctAnswers += 1
                                speechManager.speak(question.explanation ?? "Nice job!")
                            }
                            viewModel.round += 1
                            if viewModel.round < 6 {
                                viewModel.getNextQuestion()
                            }else {
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
            .padding(.top, 100)
            if showModal {
                GameOverModalView(
                    message: "Time's up ⏱️! Your score: \(viewModel.correctAnswers)",
                    onPlayAgain: {
                        showModal = false
                        toothStage = 1
                        viewModel.playAgain()
                    }
                )
                .transition(.scale)
                .animation(.easeInOut, value: showModal)
                .zIndex(1)
                    
            }
        }
        .onChange(of: viewModel.gameOver) { isGameOver in
            if isGameOver {
                showModal = true
            }
        }
    }
}

#Preview {
    HygieneGameView()
}
