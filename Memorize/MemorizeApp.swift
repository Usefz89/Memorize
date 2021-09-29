//
//  MemorizeApp.swift
//  Memorize
//
//  Created by yousef zuriqi on 25/09/2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
