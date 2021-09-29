//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by yousef zuriqi on 25/09/2021.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    static var emojis = ["✈️", "🚁", "🚤", "🚀", "🛫", "🚜", "🚛", "🚚", "🚌", "🚙", "🚕", "🚗", "🚑", "🚓", "🛻", "🛵"]
    static func makeEmojiGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 4) { index  in
            return emojis[index]
        }
    }
    
   @Published private var model: MemoryGame<String> = makeEmojiGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose( _ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    
    
    
}
