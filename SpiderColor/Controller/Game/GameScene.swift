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
    var lastMovement: Movement?
    
    var topMargin: CGFloat
    var bottomMargin: CGFloat

    // MARK: - Lifecycle

    init(size: CGSize, top: CGFloat, bottom: CGFloat) {
        self.topMargin = top
        self.bottomMargin = bottom
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sceneDidLoad() {
        anchorPoint = CGPoint(x: 0, y: 1)
        backgroundColor = .clear
        let width = size.width

        var topMargin = self.topMargin + 30
        let gradientHeight: CGFloat = 40
        gradientNode = GradientNode(colors: colors, size: CGSize(width: width - 40, height: gradientHeight))
        addChild(gradientNode)
        gradientNode.position = CGPoint(x: 20, y: -topMargin)
        topMargin += gradientHeight

        let cards = colors.enumerated().map { Card(value: $0, color: $1) }.shuffled()
        let slots = [Array(cards[0..<3]), Array(cards[3..<6]), Array(cards[6..<9])]

        let horizontalMargin: CGFloat = 20
        let slotCount = slots.count

        let spacing = horizontalMargin
        let slotWidth = (width - 2 * horizontalMargin - CGFloat(slotCount - 1) * spacing) / CGFloat(slotCount)
        let slotHeight = size.height - topMargin - bottomMargin

        for i in 0..<slotCount {
            let deck = Deck(cards: slots[i])
            let slotNode = SlotNode(size: CGSize(width: slotWidth, height: slotHeight), deck: deck)
            slotNode.delegate = self
            slotNode.position = CGPoint(x: CGFloat(i) * (spacing + slotWidth) + horizontalMargin + spacing, y: -90)
            slotNode.position = CGPoint(x: CGFloat(i) * (spacing + slotWidth) + horizontalMargin, y: -topMargin)
            addChild(slotNode)
            slotNodes.append(slotNode)
        }
    }

    override func didMove(to view: SKView) {
//        let backgroundSound = SKAudioNode(fileNamed: "background.wav")
//        addChild(backgroundSound)
//        backgroundSound.run(.group([
//            .changeVolume(to: 0.05, duration: 0),
//            .play()
//        ]))
    }

    func getSlot(for point: CGPoint) -> SlotNode? {
        slotNodes.first(where: { $0.frame.contains(point) })
    }

    func update(movement: Movement) {
        lastMovement = movement
    }

    func undoMovement() {
        if let movement = lastMovement {
            _ = movement.slotDestination.move(movement.deckNode, to: movement.slotSource)
        }
    }
}
