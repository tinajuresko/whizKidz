//
//  InfoButton.swift
//  whizKidz
//
//  Created by Tina Jureško on 26.03.2025..
//

import SwiftUI

struct InfoButton: View {
    @Binding var showAlert: Bool
    let instructions: String

    var body: some View {
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
                      message: Text(instructions),
                      dismissButton: .default(Text("Got it!")))
            }
        }
    }
}

