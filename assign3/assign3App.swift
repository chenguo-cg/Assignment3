//
//  assign3App.swift
//  assign3
//
//  Created by Guo Chen on 11/2/22.
//

import SwiftUI

@main
struct assign3App: App {
    
    private let game = FirstSetGame()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
