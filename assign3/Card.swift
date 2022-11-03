//
//  Card.swift
//  assign3
//
//  Created by Guo Chen on 11/2/22.
//

import Foundation

struct Card: Identifiable{
    let id: Int
    var isSet: Bool?
    var isChosen = false
    let numOfSymbol: Int
    let symbol: Symbol
    let shading: Shading
    let color: Color
    
    enum Symbol: CaseIterable {
        case rectangle
        case oval
        case diamond
    }
    
    
    enum Shading: CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Color: CaseIterable {
        case green
        case purple
        case red
    }
}
