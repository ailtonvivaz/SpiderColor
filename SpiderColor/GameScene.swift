//
//  GameScene.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene {
    override func sceneDidLoad() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let deck = Deck(card: Card(color: .red))
            .with(card: Card(color: .blue))
            .with(card: Card(color: .yellow))

        let node = DeckNode(deck: deck, width: 100)

        addChild(node)
    }
}
