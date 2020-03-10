//
//  Card.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SpriteKit

class CardNode: SKSpriteNode {
    init(card: Card, width: CGFloat) {
        let height: CGFloat = width / 0.72

        super.init(texture: SKTexture(image: UIImage(named: "PaperCard")!), color: card.color, size: CGSize(width: width, height: height))
        colorBlendFactor = 1
        anchorPoint = CGPoint(x: 0, y: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
