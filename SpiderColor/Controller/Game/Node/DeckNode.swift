//
//  DeckNode.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SpriteKit

class DeckNode: SKNode {
    private var offsettedPosition: CGPoint { CGPoint(x: 0, y: -(0.25 * self.width)) }
    
    private var width: CGFloat
    var deck: Deck
    var parentNode: DeckNode?
    var childNode: DeckNode?
    var originalZPosition: CGFloat = 0
    
    private var dragOffset: CGPoint = .zero
    private var isDragging: Bool = false
    
    var deckDraggable: DeckNode? {
        self.deck.isDraggable ? self : self.childNode?.deckDraggable
    }
    
    init(deck: Deck, width: CGFloat) {
        self.deck = deck
        self.width = width
        super.init()
        
        let cardNode = CardNode(card: deck.card, width: width)
        addChild(cardNode)
        
        if let child = deck.childDeck {
            let deckNode = DeckNode(deck: child, width: width)
            add(deckNode: deckNode)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func normalPosition(for point: CGPoint) -> CGPoint {
        self.offsettedPosition + (point - dragOffset)
    }
    
    func drag(to point: CGPoint) {
        print("drag", self.isDragging)
        if self.isDragging { return }
        self.isDragging = true
        self.originalZPosition = zPosition
        self.zPosition = 10000
        self.dragOffset = point
    }
    
    func move(to point: CGPoint) {
        self.position = self.normalPosition(for: point)
    }
    
    func drop() {
        print("drop", self.parentNode != nil, self.offsettedPosition)
        run(.group([
            .scale(to: 1, duration: 0.1),
            .move(to: self.parentNode != nil ? self.offsettedPosition : .zero, duration: 0.1),
        ])) {
            self.zPosition = self.originalZPosition
            self.isDragging = false
            print(self.position)
        }
    }
    
    func add(deckNode: DeckNode) {
        deckNode.parentNode = self
        self.childNode = deckNode
        deckNode.zPosition = zPosition + 1
        deckNode.position = self.offsettedPosition
        addChild(deckNode)
    }
    
    func move(to other: DeckNode) {
        if let child = other.childNode {
            self.move(to: child)
        } else {
            self.parentNode?.childNode = nil
            self.parentNode = other
            other.childNode = self
            self.deck.move(to: other.deck)
            self.move(toParent: other)
            
            zPosition = 1
            self.drop()
            zPosition = other.zPosition + 1
        }
    }
    
    func toString() -> String {
        "\(self.deck.card.value) | \(self.childNode?.toString() ?? "end")"
    }
}
