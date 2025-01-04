//
//  GreetingsViewModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 01.01.2025..
//

import Foundation

class GreetingsViewModel: ObservableObject {
    @Published var displayedText: String = ""
    
    let allGreetings = ["Hi Buddy, long time no see!", "What do you want to play today, what mood are you in?", "What a hardworking bee you are!"]
    
    func getRandomGreetings() {
        let shuffledGreetings = allGreetings.shuffled()
        displayedText = shuffledGreetings[0]
    }
    
}
