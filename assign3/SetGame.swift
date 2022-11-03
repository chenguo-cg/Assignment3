//
//  SetGame.swift
//  assign3
//
//  Created by Guo Chen on 11/2/22.
//

import SwiftUI
import Foundation

struct SetGame {
    private(set) var deck: [Card]
    private(set) var table: [Card]
    
    private struct GameConstant {
        static let numOfCardOnTable = 12
        static let numOfMatchCard = 3
        static let numOfDealCard = 3
    }
    
    private var indOfChosen: [Int] {
        get { table.indices.filter { table[$0].isChosen} }
    }
    
    private var isMatch: Bool {
        get {
            if indOfChosen.count == GameConstant.numOfMatchCard {
                let card1 = table[indOfChosen[0]]
                let card2 = table[indOfChosen[1]]
                let card3 = table[indOfChosen[2]]
                
                let isSetOfNumOfShape = (card1.numOfSymbol == card2.numOfSymbol && card1.numOfSymbol == card3.numOfSymbol) || (card1.numOfSymbol != card2.numOfSymbol && card2.numOfSymbol != card3.numOfSymbol && card1.numOfSymbol != card3.numOfSymbol)
                let isSetOfColor = (card1.color == card2.color && card1.color == card3.color) ||
                (card1.color != card2.color && card2.color != card3.color && card1.color != card3.color)
                let isSetOfSymbol = (card1.symbol == card2.symbol && card1.symbol == card3.symbol) ||
                (card1.symbol != card2.symbol && card2.symbol != card3.symbol && card1.symbol != card3.symbol)
                let isSetOfShading = (card1.shading == card2.shading && card1.shading == card3.shading) ||
                (card1.shading != card2.shading && card2.shading != card3.shading && card1.shading != card3.shading)
                
                return isSetOfColor && isSetOfSymbol && isSetOfNumOfShape && isSetOfShading
            } else {
                return false
            }
        }
    }
    
    init() {
        deck = []
        var id = 0
        for symbol in Card.Symbol.allCases {
            for shading in Card.Shading.allCases {
                for color in Card.Color.allCases {
                    for number in 1...3 {
                        deck.append(Card(id: id, numOfSymbol: number, symbol: symbol, shading: shading, color: color))
                        id += 1
                    }
                }
            }
        }
        deck.shuffle()

        table = []
        for _ in 0..<GameConstant.numOfCardOnTable {
            table.append(deck.popLast()!)
        }
    }
    
    mutating func choose(_ card: Card) {
        if indOfChosen.count == GameConstant.numOfMatchCard {
            if isMatch {
                replaceNewCard()
            }
            table.indices.forEach {
                table[$0].isChosen = false
                table[$0].isSet = nil
            }
        }
        
        if let chosenIndex = table.firstIndex(where: {$0.id == card.id}) {
            table[chosenIndex].isChosen.toggle()
            if indOfChosen.count == GameConstant.numOfMatchCard {
                let isMatch = isMatch
                indOfChosen.forEach({ i in
                    table[i].isSet = isMatch
                })
            }
        }
    }
    
    private mutating func replaceNewCard() {
        indOfChosen.reversed().forEach({ i in
            table.remove(at: i)
            if !deck.isEmpty {
                table.insert(deck.popLast()!, at: i)
            }
        })
    }
    
    mutating func dealThreeMoreCard() {
        if indOfChosen.count == GameConstant.numOfMatchCard {
            if isMatch {
                replaceNewCard()
                return
            }
        }
        for _ in 0..<GameConstant.numOfDealCard {
            table.append(deck.popLast()!)
        }
    }
    
}
