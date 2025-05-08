//
//  AlphabetView.swift
//  whizKidz
//
//  Created by Tina Jureško on 01.01.2025..
//


import SwiftUI

struct AlphabetView: View {
    @StateObject private var viewModel = AlphabetViewModel()
    @State private var showAlert = false
    @State private var correctMatch: Bool = false
    @State private var selectedImage: String = ""
    @State private var selectedLetter: String = ""
    @State private var matchedItems: [(image: String, letter: String)] = []
    
    @State private var showModal: Bool = false
    @State private var honeyStage: Int = 1
    
    var body: some View {
            ZStack {
                Image("appBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
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
                                message: Text("Click on a letter, then choose an image that features an object or item starting with that letter. Try to match all the letters with their corresponding images as quickly as possible to help the worker bee produce delicious honey. 🐝🍯"),
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

                    Image("honey\(honeyStage)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding()
                        .transition(.scale)
                        .animation(.easeInOut, value: honeyStage)
                    
                    Spacer()

                    
                    HStack {
                        ForEach(viewModel.currentRound, id: \.image) { item in
                           Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 200)
                                .background(Color.white)
                                .shadow(
                                    color: matchedItems.contains(where: { $0.letter == selectedLetter && $0.image == item.image }) ? .green : .clear,
                                        radius: 5, x: 0, y: 5
                                )
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .offset(y: -100)
                                .onTapGesture {
                                    imageTapped(image: item.image)
                                }
                        }
                        .offset(y: -50)
                    }
                    
                    HStack {
                        ForEach(viewModel.shuffledLetters, id: \.self) { letter in
                            Text(letter)
                                .font(.largeTitle)
                                .bold()
                                .padding()
                                .background(selectedLetter == letter ? Color.yellow.opacity(0.7) : Color.blue.opacity(0.7))
                                .shadow(color: matchedItems.contains(where: { $0.letter == letter && $0.image == selectedImage }) ? .green : .gray, radius: 5, x: 0, y: 5)
                                .cornerRadius(8)
                                .onTapGesture {
                                    letterTapped(letter: letter)
                                }

                        }
                    }
                    .offset(y: -50)
                    .padding(.bottom, 80)
                    
                }
                .padding(.top, 100)
                
                if showModal {
                    GameOverModalView(
                        message: "Time's up ⏱️! Your score: \(viewModel.score)",
                        onPlayAgain: {
                            showModal = false
                            honeyStage = 1
                            viewModel.playAgain()
                        }
                    )
                    .transition(.scale)
                    .animation(.easeInOut, value: showModal)
                    .zIndex(1)
                        
                }
            }
            .onChange(of: viewModel.gameIsOver) { isGameOver in
                if isGameOver {
                    showModal = true
                }
            }
    }
    
    func imageTapped (image: String) {
        selectedImage = image
        correctMatch = viewModel.checkMatch(letter: selectedLetter, image: selectedImage)
        print(correctMatch)
        
        if correctMatch {
            matchedItems.append((image: selectedImage, letter: selectedLetter))
        }
        
        if viewModel.correctMatches == 3 && viewModel.round <= 5{
            selectedImage = ""
            selectedLetter = ""
            honeyStage += 1
            viewModel.startNewRound()
        }
    }
    
    func letterTapped (letter: String) {
        selectedLetter = letter
        correctMatch = viewModel.checkMatch(letter: selectedLetter, image: selectedImage)
        print(correctMatch)
        
        if correctMatch {
            matchedItems.append((image: selectedImage, letter: selectedLetter))
        }
        
        if viewModel.correctMatches == 3 && viewModel.round <= 5{
            selectedImage = ""
            selectedLetter = ""
            honeyStage += 1
            viewModel.startNewRound()
        }
    }
}

#Preview {
    AlphabetView()
}
