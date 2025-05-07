//
//  HygieneModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 25.03.2025..
//

import Foundation

struct HygieneProblem: ProblemProtocol, Equatable {
    let id = UUID()
    let question: String
    let answers: [String]
    let correctAnswer: [String]
    let explanation: String?
}

let hygieneProblems: [HygieneProblem] = [
   HygieneProblem(question: "When should you wash your hands?",
                  answers: ["Before eating", "After using the restroom", "After playing outside", "All of the above"],
                  correctAnswer: ["All of the above"],
                  explanation: "Washing hands prevents the spread of germs and should be done regularly."),
   HygieneProblem(
           question: "How long should you wash your hands with soap and water?",
           answers: ["5 seconds", "10 seconds", "20 seconds", "1 minute"],
           correctAnswer: ["20 seconds"],
           explanation: "Washing for at least 20 seconds removes most germs."
       ),
   HygieneProblem(
           question: "What is the best way to dry your hands after washing?",
           answers: ["Shake them in the air", "Use a clean towel", "Wipe them on your clothes", "Let them dry naturally"],
           correctAnswer: ["Use a clean towel"],
           explanation: "Using a clean towel helps remove remaining germs and prevents the spread of bacteria."
       ),
   HygieneProblem(
           question: "Which of these is the best way to sneeze or cough?",
           answers: ["Into your hands", "Into a tissue", "Into your elbow", "Into the air"],
           correctAnswer: ["Into a tissue", "Into your elbow"],
           explanation: "Coughing or sneezing into your elbow or a tissue prevents germs from spreading to others."
       ),
   HygieneProblem(
           question: "How often should you brush your teeth?",
           answers: ["Once a week", "Every morning", "Twice a day", "Only when they feel dirty"],
           correctAnswer: ["Twice a day"],
           explanation: "Brushing your teeth twice a day helps prevent cavities and keeps your mouth healthy."
       ),
   HygieneProblem(
           question: "What should you do with a used tissue?",
           answers: ["Put it in your pocket", "Throw it in the trash", "Leave it on a table", "Give it to someone else"],
           correctAnswer: ["Throw it in the trash"],
           explanation: "Used tissues should be thrown away immediately to prevent the spread of germs."
       ),
   HygieneProblem(
           question: "Why is it important to wash fruits and vegetables before eating?",
           answers: ["To remove dirt and germs", "To make them taste better", "To change their color", "It is not necessary"],
           correctAnswer: ["To remove dirt and germs"],
           explanation: "Washing fruits and vegetables helps remove harmful bacteria, pesticides, and dirt."
       ),
   HygieneProblem(
           question: "Which of these is NOT a good hygiene habit?",
           answers: ["Washing hands before meals", "Sharing a toothbrush", "Taking a shower regularly", "Keeping nails trimmed"],
           correctAnswer: ["Sharing a toothbrush"],
           explanation: "Sharing a toothbrush can spread bacteria and germs, leading to infections."
       ),
   HygieneProblem(
           question: "How often should you change your socks?",
           answers: ["Once a week", "Every day", "Whenever they start smelling", "Only when they get wet"],
           correctAnswer: ["Every day"],
           explanation: "Changing socks daily helps prevent foot odor and infections caused by bacteria."
       ),
   HygieneProblem(
          question: "What happens if you don't wash your hands after using the restroom?",
          answers: ["Nothing", "You can spread germs and bacteria", "Your hands will feel dry", "You will get hungry"],
          correctAnswer: ["You can spread germs and bacteria"],
          explanation: "Not washing your hands after using the restroom can spread harmful bacteria and cause illness."
      ),
   HygieneProblem(
           question: "Why is it important to clean under your fingernails?",
           answers: ["To make them look nice", "Because germs can hide there", "So they grow faster", "It is not important"],
           correctAnswer: ["Because germs can hide there"],
           explanation: "Germs and dirt can collect under fingernails, so regular cleaning is necessary to prevent illness."
       ),
   HygieneProblem(
           question: "Why should you take a shower regularly?",
           answers: ["To smell good", "To remove germs and bacteria", "To keep your skin healthy", "All of the above"],
           correctAnswer: ["All of the above"],
           explanation: "Taking regular showers keeps you clean, prevents germs from spreading, and keeps your skin healthy."
       ),
   HygieneProblem(
           question: "What should you do if your clothes get dirty and sweaty?",
           answers: ["Wear them again", "Wash them", "Spray perfume on them", "Turn them inside out"],
           correctAnswer: ["Wash them"],
           explanation: "Washing dirty clothes helps remove bacteria and prevents bad odors."
       ),
   HygieneProblem(
           question: "Why is it important to keep your toothbrush clean?",
           answers: ["So it lasts longer", "To avoid bacteria buildup", "To make it look good", "It is not important"],
           correctAnswer: ["To avoid bacteria buildup"],
           explanation: "Keeping your toothbrush clean prevents bacteria from spreading and protects your oral health."
       )
   
]
