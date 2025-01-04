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
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
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
                                message: Text("Click on a letter, then choose an image that features an object or item starting with that letter. Try to match all the letters with their corresponding images as quickly as possible. Aim to complete the game with the fewest attempts."),
                                dismissButton: .default(Text("Got it!")))
                        }
                                            
                        Spacer()
                    }
                    .padding([.top, .leading])

                    GifImageView(name: "game")
                        .frame(width: 120, height: 120)
                        .padding(.top, 50)
                    
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
                                .background(selectedLetter == letter ? Color.yellow.opacity(0.2) : Color.blue.opacity(0.2))
                                .shadow(color: matchedItems.contains(where: { $0.letter == letter && $0.image == selectedImage }) ? .green : .gray, radius: 5, x: 0, y: 5)
                                .cornerRadius(8)
                                .onTapGesture {
                                    letterTapped(letter: letter)
                                }

                        }
                    }
                    .offset(y: -50)
                    
                }
            }
            
            .sheet(isPresented: $showModal) {
                GameOverModalView( message: "Congratulations! You did great! 🏆",
                onPlayAgain: {
                    showModal = false
                    viewModel.playAgain()
                })
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
            viewModel.startNewRound()
        }
        
        if viewModel.round > 5 { showModal = true }
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
            viewModel.startNewRound()
        }
        
        if viewModel.round > 5 { showModal = true }
        
    }
    
}

#Preview {
    AlphabetView()
}
