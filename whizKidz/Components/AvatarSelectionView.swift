//
//  AvatarSelectionView.swift
//  whizKidz
//
//  Created by Tina Jureško on 06.03.2025..
//

import SwiftUI

struct AvatarSelectionView: View {
    @Binding var selectedAvatar: String
    let avatars = (1...18).map {"avatar\($0)"}
    
    var body: some View {
        Text("Choose your Avatar")
            .font(.headline)
            .padding()
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
            ForEach(avatars, id: \.self) { avatar in
                Image(avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding()
                    .background(selectedAvatar == avatar ? Color.blue.opacity(0.3) : Color.clear)
                            .clipShape(Circle())
                            .onTapGesture {
                                selectedAvatar = avatar
                            }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var previewAvatar = "avatar1"
    AvatarSelectionView(selectedAvatar: $previewAvatar)
}
