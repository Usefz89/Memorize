//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by yousef zuriqi on 25/09/2021.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static var emojis = ["✈️", "🚁", "🚤", "🚀", "🛫", "🚜", "🚛", "🚚", "🚌", "🚙", "🚕", "🚗", "🚑", "🚓", "🛻", "🛵", "🚝", "🚄", "🚁", "🛶", "🛳"]
    static func makeEmojiGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 8) { index  in
            return emojis[index]
        }
    }
    
   @Published private var model = makeEmojiGame()
    
    var cards: [Card] {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose( _ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    
    
    
}
