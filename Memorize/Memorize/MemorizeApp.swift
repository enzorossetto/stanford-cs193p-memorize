//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Enzo Rossetto on 12/10/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
