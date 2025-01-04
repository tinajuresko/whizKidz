//
//  MemoryCardView.swift
//  whizKidz
//
//  Created by Tina Jureško on 04.01.2025..
//

import SwiftUI

struct MemoryCardView: View {
    var card: MemoryCard
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            if card.isFlipped {
                ZStack {
                    Color(getColorForCard(card.color))
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                    Text(card.color.rawValue.capitalized)
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                }
                
            }
        }
        .animation(.easeInOut(duration: 0.3), value: card.isFlipped)
    }
    
    func getColorForCard(_ color: ColorChoice) -> Color {
        switch color {
            case .red: return .red
            case .blue: return .blue
            case .green: return .green
            case .yellow: return .yellow
            case .orange: return .orange
            case .purple: return .purple
            case .pink: return .pink
        }
    }
}

#Preview {
    MemoryCardView(card: MemoryCard(color: ColorChoice.red, isFlipped: false))
}
