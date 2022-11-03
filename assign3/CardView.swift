//
//  CardView.swift
//  assign3
//
//  Created by Guo Chen on 11/2/22.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                VStack {
                    ForEach(0..<card.numOfSymbol, id:\.self) { _ in
                        symbol
                            .frame(width: geometry.size.width/2, height: geometry.size.height/6)
                    }
                }
                .foregroundColor(cardColor)
                if card.isChosen {
                    shape.foregroundColor(.gray).opacity(0.5)
                }
                if let isSet = card.isSet {
                    shape.foregroundColor(isSet ? .green : .red).opacity(0.6)
                }
            }
        })
        
    }
    
    @ViewBuilder
    private var symbol: some View{
        switch card.symbol {
        case .diamond:
            switch card.shading {
            case .solid: Diamond()
            case .striped: Diamond().opacity(0.5)
            case .open: Diamond().stroke()
            }
        case .oval:
            switch card.shading {
            case .solid: Capsule()
            case .striped: Capsule().opacity(0.5)
            case .open: Capsule().stroke()
            }
        case .rectangle:
            switch card.shading {
            case .solid: Rectangle()
            case .striped: Rectangle().opacity(0.5)
            case .open: Rectangle().stroke()
            }
        }
    }
    
    private var cardColor: Color {
        switch card.color {
        case .red: return .red
        case .purple: return .purple
        case .green: return .green
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(id: 1, numOfSymbol: 3, symbol: Card.Symbol.oval, shading: Card.Shading.solid, color: Card.Color.purple)
        CardView(card: card).frame(width: 200, height: 200)
    }
}
