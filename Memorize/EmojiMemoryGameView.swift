//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by yousef zuriqi on 25/09/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject  var game: EmojiMemoryGame
    var body: some View {
        VStack {
            gameBody
            shuffle
        }
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func notDealt(_ card: EmojiMemoryGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if notDealt(card) || ( card.isMatched && !card.isFaceUp) {
                Color.clear
            }else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            game.choose(card)
                        }
                    }
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            withAnimation {
                for card in game.cards {
                    deal(card)
                }
            }
        }
        .padding(.horizontal)
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
                ZStack {
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(DrawingConstants.circlePadding)
                        .opacity(DrawingConstants.opacity)
                    Text(card.content)
                        .rotationEffect(card.isMatched ? Angle.degrees(360) : Angle.degrees(0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        .font(Font.system(size: DrawingConstants.fontSize))
                        .scaleEffect(scaleThatFit(in: geometry.size ))
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
    
    private func scaleThatFit(in size: CGSize) -> CGFloat {
        return min(size.width, size.height) * DrawingConstants.fontScale / DrawingConstants.fontSize
        // Check it if there is a problem in sizing the emoji later on
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontSize: CGFloat = 32
        static let circlePadding: CGFloat = 5
        static let opacity: Double = 0.5
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.6
        
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            
    }
}
