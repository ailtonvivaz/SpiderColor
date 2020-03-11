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

    var colors = [UIColor.red.mix(with: UIColor.white, percent: 0.2), UIColor.blue.mix(with: .red, percent: 0.2).mix(with: .white, percent: 0.2)].generateGradient(of: 8)

    // MARK: - Lifecycle

    override func sceneDidLoad() {
        anchorPoint = CGPoint(x: 0, y: 1)
        backgroundColor = .clear
        
//        colors.shuffle()
    }

    override func didMove(to view: SKView) {
        print("didMove")

        let width = view.frame.width
        let slotCount = 3
        let slotWidth = 0.2 * width
        
        let spacing = (width - (slotWidth * CGFloat(slotCount))) / CGFloat(slotCount + 1)

        for i in 0..<slotCount {
            let deck = Deck(cards: colors.map { Card(color: $0) })
            let node = DeckNode(deck: deck, width: 0.2 * width)
            node.position = CGPoint(x: CGFloat(i) * (spacing + slotWidth) + spacing, y: -90)
            addChild(node)
        }
    }
}
