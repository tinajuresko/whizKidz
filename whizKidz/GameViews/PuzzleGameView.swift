//
//  PuzzleGameView.swift
//  whizKidz
//
//  Created by Tina Jureško on 23.02.2025..
//

import SwiftUI

struct PuzzleGameView: View {
    @State private var showModal: Bool = false
    @State private var showAlert = false
    @StateObject private var viewModel = PuzzleViewModel()
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    
    
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
                            message: Text("Unscramble the letters to form the correct word! Click on the letters in the right order and help the butterfly reach the flower. Each correct word moves the butterfly closer to the flower. Can you complete all the words and help the butterfly find its way? 🦋🌸"),
                            dismissButton: .default(Text("Got it!")))
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Time: \(viewModel.timeRemaining)s")
                            .font(.title3)
                            .foregroundColor(.red)
                        Text("Score: \(viewModel.score)")
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                .padding([.top, .leading])
                
                Spacer()
                
                ProgressView(progress: $viewModel.progress)
                    .frame(height: 60)
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(Array(viewModel.scrambledLetters.enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.system(size: viewModel.currentWord.word.count > 10 ? 20 : 30))
                            .bold()
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                            .cornerRadius(8)
                            .onTapGesture {
                                viewModel.selectLetter(letter: letter)
                                if viewModel.gameIsOver {
                                    showModal = true
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(Array(viewModel.selectedLetters.enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.system(size: 30))
                            .bold()
                            .padding()
                            .background(Color.green.opacity(0.3))
                            .cornerRadius(8)
                            .onTapGesture {
                                viewModel.removeSelectedLetter(at: index)
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
            }
            if showModal {
                GameOverModalView(
                    message: "Time's up ⏱️! Your score: \(viewModel.score)",
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
        .onAppear() {
            viewModel.getNextWord()
        }
        .onChange(of: viewModel.gameIsOver) { isGameOver in
            if isGameOver {
                showModal = true
            }
        }
    }
}

#Preview {
    PuzzleGameView()
}
