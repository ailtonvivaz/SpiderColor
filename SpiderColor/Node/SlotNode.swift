//
//  SlotNode.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 10/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SpriteKit

class SlotNode: SKSpriteNode {
    var deck: Deck?
    
//    init(size: CGSize) {
////        self.ini
////        self.init(color: .clear, size: size)
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(deck: Deck) {
        addChild(DeckNode(deck: deck, width: size.width))
    }
}
