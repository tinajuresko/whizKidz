//
//  ThemeCard.swift
//  whizKidz
//
//  Created by Tina Jureško on 31.12.2024..
//

import SwiftUI

struct ThemeCard: View {
    var imageName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
            Text(text)
                .font(.headline)
                .foregroundStyle(Color.black)
        }
        .frame(width: 200, height: 70)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    ThemeCard(imageName: "math", text: "Learn Math!")
}
