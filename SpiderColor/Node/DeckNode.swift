//
//  DeckNode.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SpriteKit

class DeckNode: SKShapeNode {
    private var originalPosition: CGPoint!
    
    init(deck: Deck, width: CGFloat) {
        super.init()
        self.isUserInteractionEnabled = true
        
        let cardNode = CardNode(card: deck.card, width: width)
        addChild(cardNode)
        
        if let childDeck = deck.childDeck {
            let deckNode = DeckNode(deck: childDeck, width: width)
            
            deckNode.position = CGPoint(x: 0, y: -(0.5 * width))
            addChild(deckNode)
        }
        
        print("teste")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.originalPosition = position
        run(.scale(to: 1.2, duration: 0.1))
        
        if let touch = touches.first {
            run(.move(to: touch.location(in: self.parent!), duration: 0.1))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.position = touch.location(in: self.parent!)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(.group([
            .scale(to: 1, duration: 0.1),
            .move(to: self.originalPosition, duration: 0.1),
        ]))
    }
}
