//
//  ColorGameView.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import SwiftUI

struct ColorGameView: View {
    @StateObject private var viewModel = ColorViewModel()
    @State private var showAlert = false
    
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
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
                            message: Text("Turn over the cards to find matching pairs of colors. Click on a card to flip it and try to match it with another one. Try to match all the pairs with the least amount of moves."),
                            dismissButton: .default(Text("Got it!")))
                    }
                    Spacer()
                    Text("Score: \(viewModel.score)")
                        .font(.title2)
                        .foregroundStyle(Color.blue)
                        .padding()
                }
                
                
                        
                LazyVGrid(columns: gridLayout, spacing: 20) {
                    ForEach(viewModel.cards) { card in
                        MemoryCardView(card: card)
                            .onTapGesture {
                                viewModel.flipCard(card: card)
                            }
                    }
                }
                .padding()
                
                
                Button(action: {
                    viewModel.resetGame()
                }) {
                    Text("Restart Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
        }
    }
}



#Preview {
    ColorGameView()
}
