//
//  DeckNode.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SpriteKit

class DeckNode: SKNode {
    private var originalPosition: CGPoint!
    
    private var width: CGFloat
    var deck: Deck
    var parentNode: DeckNode?
    var childNode: DeckNode?
    var originalZPosition: CGFloat = 0
    
    var deckDraggable: DeckNode? {
        self.deck.isDraggable ? self : self.childNode?.deckDraggable
    }
    
    init(deck: Deck, width: CGFloat) {
        self.deck = deck
        self.width = width
        super.init()
//        self.isUserInteractionEnabled = true
        
        if !deck.isEmpty {
            let cardNode = CardNode(card: deck.card, width: width)
            addChild(cardNode)
        }
        
        if let child = deck.childDeck {
            let deckNode = DeckNode(deck: child, width: width)
            add(deckNode: deckNode)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func normalPosition(for point: CGPoint) -> CGPoint {
        point - CGPoint(x: calculateAccumulatedFrame().width / 2, y: 0)
    }
    
    func drag(to point: CGPoint) {
        self.originalZPosition = zPosition
        self.zPosition = 10000
        self.originalPosition = position
        run(.group([
            .scale(to: 1.2, duration: 0.1),
            .move(to: self.normalPosition(for: point), duration: 0.1),
        ]))
    }
    
    func move(to point: CGPoint) {
        self.position = self.normalPosition(for: point)
    }
    
    func drop() {
        run(.group([
            .scale(to: 1, duration: 0.1),
            .move(to: self.originalPosition, duration: 0.1),
        ])) {
            self.zPosition = self.originalZPosition
        }
    }
    
    func add(deckNode: DeckNode) {
        deckNode.parentNode = self
        self.childNode = deckNode
        deckNode.zPosition = zPosition + 1
        deckNode.position = CGPoint(x: 0, y: -(0.25 * self.width))
        addChild(deckNode)
    }
    
    func move(to other: DeckNode) {
        if let child = other.childNode {
            self.move(to: child)
        } else {
            self.parentNode?.childNode = nil
            self.parentNode = other
            other.childNode = self
            zPosition = other.zPosition + 1
            self.deck.move(to: other.deck)
            position = CGPoint(x: 0, y: -(0.25 * self.width))
            self.move(toParent: other)
        }
//                if let child = deckChild {
//                    child.add(deckNode: deckNode)
//                } else {
//                    self.deckChild = deckNode
//                    deckNode.zPosition = zPosition + 1
//
//                    deckNode.deck.change(to: self.deck)
//
//                    deckNode.position = CGPoint(x: 0, y: -(0.25 * self.width))
//                    deckNode.move(toParent: self)
//
//        //            addChild(deckNode)
//                }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.originalPosition = position
//        run(.scale(to: 1.2, duration: 0.1))
//
//        if let touch = touches.first {
//            run(.move(to: self.normalPosition(for: touch.location(in: self.parent!)), duration: 0.1))
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            self.position = self.normalPosition(for: touch.location(in: self.parent!))
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        run(.group([
//            .scale(to: 1, duration: 0.1),
//            .move(to: self.originalPosition, duration: 0.1),
//        ]))
//    }
}
