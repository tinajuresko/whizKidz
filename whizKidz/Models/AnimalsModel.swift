//
//  AnimalsModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 26.03.2025..
//

import Foundation

struct Animal: Equatable {
    let name: String
    let funFacts: [String]
}

let animals: [Animal] = [
    Animal(name: "Cow", funFacts: [
        "Cows have best friends and get stressed when they are separated.",
        "They have a great sense of smell and can detect odors up to six miles away.",
        "Cows have almost 360-degree vision, allowing them to see predators coming from any direction."
    ]),
    Animal(name: "Crab", funFacts: [
        "Crabs have ten legs, but the front two are claws used for catching food and defense.",
        "Some crabs can walk forward and backward, but most move sideways.",
        "Fiddler crabs use one giant claw to attract mates and communicate."
    ]),
    Animal(name: "Deer", funFacts: [
        "Deer can run up to 30 miles per hour to escape predators.",
        "Their eyes are on the sides of their head, giving them a wide field of vision.",
        "Male deer grow and shed their antlers every year."
    ]),
    Animal(name: "Dolphin", funFacts: [
        "Dolphins sleep with one eye open and one half of their brain awake.",
        "They communicate using clicks, whistles, and body movements.",
        "Dolphins have names for each other and recognize themselves in mirrors."
    ]),
    Animal(name: "Elephant", funFacts: [
        "Elephants have the largest brain of any land animal.",
        "They can 'hear' with their feet by sensing vibrations in the ground.",
        "Elephants are highly empathetic and comfort each other when distressed."
    ]),
    Animal(name: "Frog", funFacts: [
        "Frogs absorb water through their skin, so they don't need to drink.",
        "Some frogs can freeze solid in the winter and thaw out in spring!",
        "A group of frogs is called an 'army'."
    ]),
    Animal(name: "Jellyfish", funFacts: [
        "Jellyfish have existed for over 500 million years, making them older than dinosaurs.",
        "They have no brain, heart, or bones.",
        "The Turritopsis dohrnii jellyfish is considered 'immortal' because it can revert to its juvenile form."
    ]),
    Animal(name: "Kangaroo", funFacts: [
        "Kangaroos can jump up to three times their body length in a single leap.",
        "They use their tails as a fifth limb to help with balance.",
        "A baby kangaroo, called a 'joey', lives in its mother’s pouch for about six months."
    ]),
    Animal(name: "Octopus", funFacts: [
        "Octopuses have three hearts and blue blood.",
        "They can squeeze through tiny spaces because they have no bones.",
        "Each of their arms has its own mini-brain and can act independently."
    ]),
    Animal(name: "Owl", funFacts: [
        "Owls can rotate their heads up to 270 degrees.",
        "Their feathers are designed for silent flight to help them hunt without being heard.",
        "Owls have special eyelids called 'nictitating membranes' to protect their eyes."
    ]),
    Animal(name: "Parrot", funFacts: [
        "Parrots can mimic human speech and learn dozens of words.",
        "They are one of the most intelligent bird species.",
        "Some parrots live over 80 years, making them one of the longest-living birds."
    ]),
    Animal(name: "Snake", funFacts: [
        "Snakes smell with their tongues by flicking them in and out.",
        "Some snakes can glide through the air, almost flying between trees.",
        "They can dislocate their jaws to swallow prey much larger than their head."
    ]),
    Animal(name: "Whale", funFacts: [
        "Blue whales are the largest animals to have ever lived on Earth.",
        "Humpback whales sing songs that can last for hours and travel long distances underwater.",
        "Some whales, like the bowhead whale, can live over 200 years!"
    ])
]
