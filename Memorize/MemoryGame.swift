//
//  MemoryGame.swift
//  Memorize
//
//  Created by yousef zuriqi on 25/09/2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let possibleMatchedIndex = indexOfOneAndOnlyFaceUpCard {
                if card.content == cards[possibleMatchedIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[possibleMatchedIndex].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    
    /// Create Memory game with number of pairs in the game and each pair index will be added to the closure to create the cards
    ///
    /// - Parameter numberOfPairOfCards: add number of pairs of cards in the game
    /// - Parameter createCardContent: Return card content to create pair of cards based on the pair index. 
    
    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2 ))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
       
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        
        
    }
}
