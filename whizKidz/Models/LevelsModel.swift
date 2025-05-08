//
//  LevelsModel.swift
//  whizKidz
//
//  Created by Tina Jureško on 07.05.2025..
//

import Foundation

struct Level: Identifiable {
    let id: Int
    var name: String
    var imageName: String
    var text: String
}

let levels: [Level] = [
    Level(id: 1, name: "Stardust Pebble", imageName: "level1", text: "A tiny cosmic rock born from ancient star explosions. It’s the first step into the galaxy of learning!"),
    Level(id: 2, name: "Bloomstone", imageName: "level2", text: "A rare space pebble infused with mysterious space flora. Only the most curious explorers discover it."),
    Level(id: 3, name: "Nova Fragment", imageName: "level3", text: "A rugged asteroid chunk shattered from a newborn star. Collectors say it hums with energy!"),
    Level(id: 4, name: "Solar Blaze Core", imageName: "level4", text: "A fiery golden asteroid that passed through the heart of the Sun. It glows with untamed brilliance."),
    Level(id: 5, name: "Celestite Gem", imageName: "level5", text: "A dazzling gemstone formed in zero gravity. Legends say it can spark imagination in young minds."),
    Level(id: 6, name: "Crimson Starcore", imageName: "level6", text: "A radiant ruby formed in the core of a dying red giant star. Its glow symbolizes unstoppable determination and fiery passion for discovery."),
    Level(id: 7, name: "Stellar Diamond", imageName: "level7", text: "A perfect diamond crystalized in deep space, reflecting the wisdom of a thousand galaxies."),
    Level(id: 8, name: "Cosmic Heartstone", imageName: "level8", text: "The rarest gem in the universe. Said to appear only when a child learns with heart, joy, and courage.")
]
