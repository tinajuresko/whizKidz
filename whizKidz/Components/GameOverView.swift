//
//  GameOverView.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import SwiftUI

struct GameOverModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var message: String = ""
    var onPlayAgain: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(message)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            HStack(spacing: 16) {
                Button(action: onPlayAgain) {
                    Text("Play Again")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Exit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .frame(maxWidth: 280)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 4)
        )
        .frame(maxWidth: 300)
        .transition(.scale)
        .padding(40)
    }
}

#Preview {
    GameOverModalView(message: "Great job!", onPlayAgain: {
        print("Restart tapped")
    })
}




