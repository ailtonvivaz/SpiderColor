//
//  GameScene.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene, SlotNodeDelegate {
    // MARK: - Variables

    var colors = [UIColor.red.mix(with: UIColor.white, percent: 0.2), UIColor.blue.mix(with: .red, percent: 0.2).mix(with: .white, percent: 0.2)].generateGradient(of: 9)
//    var colors = [UIColor.red.mix(with: UIColor.white, percent: 0.2), UIColor.red.mix(with: UIColor.white, percent: 0.9)].generateGradient(of: 9)

    var gradientNode: GradientNode!
    var slotNodes: [SlotNode] = []

    // MARK: - Lifecycle

    override func sceneDidLoad() {
        anchorPoint = CGPoint(x: 0, y: 1)
        backgroundColor = .clear
        let width = size.width

        gradientNode = GradientNode(colors: colors, size: CGSize(width: width - 40, height: 40))
        addChild(gradientNode)
        gradientNode.position = CGPoint(x: 20, y: -30)

            let cards = colors.enumerated().map { Card(value: $0, color: $1) }.shuffled()
        let slots = [Array(cards[0..<3]), Array(cards[3..<6]), Array(cards[6..<9])]

        let horizontalMargin: CGFloat = 20
        let slotCount = slots.count

        let spacing = horizontalMargin
        let slotWidth = (width - 2 * horizontalMargin - CGFloat(slotCount - 1) * spacing) / CGFloat(slotCount)

        for i in 0..<slotCount {
            let deck = Deck(cards: slots[i])
            let slotNode = SlotNode(size: CGSize(width: slotWidth, height: 3000), deck: Deck.empty.add(deck: deck))
            slotNode.delegate = self
            slotNode.position = CGPoint(x: CGFloat(i) * (spacing + slotWidth) + horizontalMargin + spacing, y: -90)
            slotNode.position = CGPoint(x: CGFloat(i) * (spacing + slotWidth) + horizontalMargin, y: -40)
            addChild(slotNode)
            slotNodes.append(slotNode)
        }
    }

    func getSlot(for point: CGPoint) -> SlotNode? {
        slotNodes.first(where: { $0.frame.contains(point) })
    }
}
