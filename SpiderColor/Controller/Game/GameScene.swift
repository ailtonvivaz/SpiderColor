//
//  GameScene.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import GameplayKit
import SpriteKit

protocol GameDelegate {
    func complete(level: Level)
}

class GameScene: SKScene, SlotNodeDelegate {
    // MARK: - Variables

    var level: Level
    var gameDelegate: GameDelegate?

    var colors: [UIColor] { level.colors.generateGradient(of: level.qtyCards) }
    lazy var cards = colors.enumerated().map { Card(value: $0, color: $1) }

    var gradientNode: GradientNode!
    var slotNodes: [SlotNode] = []
    var lastMovement: Movement?

    var topMargin: CGFloat
    var bottomMargin: CGFloat

    // MARK: - Lifecycle

    init(level: Level, size: CGSize, top: CGFloat, bottom: CGFloat) {
        self.level = level
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

        let shuffledCards = cards.shuffled()
        let slots = [Array(shuffledCards[0..<3]), Array(shuffledCards[3..<6]), Array(shuffledCards[6..<9])]

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

    func checkGame() {
        if let slot = slotNodes.first(where: { $0.deckSize == level.qtyCards }) {
            if slot.cards == cards {
                print("finalizado")
                gameDelegate?.complete(level: level)
            }
        }
    }

    func update(movement: Movement) {
        lastMovement = movement
        checkGame()
    }

    func undoMovement() {
        if let movement = lastMovement {
            _ = movement.slotDestination.move(movement.deckNode, to: movement.slotSource)
        }
    }
}
