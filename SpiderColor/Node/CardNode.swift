//
//  Card.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SpriteKit

class CardNode: SKShapeNode {
    init(card: Card, width: CGFloat) {
        super.init()
        
        let height = 1.8 * width
        let node = SKShapeNode(rect: CGRect(x: -width / 2, y: -height / 2, width: width, height: height), cornerRadius: 0.2 * width)
        node.fillColor = card.color
        addChild(node)
        
        print("teste")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
