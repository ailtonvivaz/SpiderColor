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
    // MARK: - Variables
    let colors = [UIColor.red.mix(with: UIColor.white, percent: 0.2), UIColor.blue.mix(with: .red, percent: 0.2).mix(with: .white, percent: 0.2)].generateGradient(of: 7)
    
    // MARK: - Lifecycle
    override func sceneDidLoad() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let deck = Deck(cards: colors.map { Card(color: $0) })

        let node = DeckNode(deck: deck, width: 70)

        addChild(node)
    }
}
