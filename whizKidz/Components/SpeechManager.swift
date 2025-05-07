//
//  SpeechManager.swift
//  whizKidz
//
//  Created by Tina Jureško on 25.03.2025..
//

import Foundation
import AVFoundation
import Speech

class SpeechManager: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
        
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")
        //utterance.rate = 0.3 // Brzina govora
        utterance.pitchMultiplier = 1.2
        synthesizer.speak(utterance)
    }
}
