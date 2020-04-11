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
    func setResolved(cards: [Card])
    func complete(level: Level)
}

extension GameDelegate {
    func setResolved(cards: [Card]) {}
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

        let topMargin = self.topMargin + 40

        let shuffledCards = cards.shuffled()

        let qtyBySlot = shuffledCards.count / 3
        let qtyMiddleSlot = qtyBySlot + (shuffledCards.count % 3)

        let slots = [
            Array(shuffledCards[0..<qtyBySlot]),
            Array(shuffledCards[qtyBySlot..<(qtyBySlot + qtyMiddleSlot)]),
            Array(shuffledCards[(qtyBySlot + qtyMiddleSlot)..<shuffledCards.count]),
        ]

        let horizontalMargin: CGFloat = 20
        let slotCount = slots.count

        let spacing: CGFloat = 30
        let slotsSpaceWidth = width - 2 * horizontalMargin
        let slotsWidth = slotsSpaceWidth - CGFloat(slotCount - 1) * spacing
        let slotWidth = slotsWidth / CGFloat(slotCount)
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
        checkGame()
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
        if let slotNode = slotNodes.first(where: { $0.deckSize == level.qtyCards }) {
            if slotNode.cards == cards {
                print("finalizado")
                gameDelegate?.complete(level: level)
            }
        }

        let cardsResolved = slotNodes.map { $0.cardsResolved }.reduce([], +)
        gameDelegate?.setResolved(cards: cardsResolved)
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
