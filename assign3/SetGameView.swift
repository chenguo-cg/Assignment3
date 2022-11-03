//
//  ContentView.swift
//  assign3
//
//  Created by Guo Chen on 11/2/22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: FirstSetGame
    
    var body: some View {
        VStack {
            HStack {
                Button("New Game") {
                    game.newGame()
                }
            }
            AspectVGrid(items: game.table, aspectRatio: 2/3, content: { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            })
            HStack {
                Button("Deal 3 More Cards") {
                    game.dealThreeMoreCard()
                }.disabled(game.deck.isEmpty)
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = FirstSetGame()
        SetGameView(game: game)
    }
    
}
