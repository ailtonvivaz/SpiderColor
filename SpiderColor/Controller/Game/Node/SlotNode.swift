//
//  SlotNode.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 10/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SpriteKit

protocol SlotNodeDelegate {
    func getSlot(for point: CGPoint) -> SlotNode?
    func update(movement: Movement)
}

class SlotNode: SKSpriteNode {
    var deckNode: DeckNode?
    var delegate: SlotNodeDelegate?
    
    var cards: [Card] { deckNode?.deck.cards ?? [] }
    var deckSize: Int { deckNode?.deck.size ?? 0 }
    
    var cardsResolved: Set<Card> {
        var cardsResolved = Set<Card>()
        var previousCard: Card?
        for card in cards {
            if let previousCard = previousCard {
                if card.isNext(of: previousCard) {
                    cardsResolved.insert(previousCard)
                    cardsResolved.insert(card)
                }
            }
            previousCard = card
        }
        return cardsResolved
    }
    
    private var deckDragging: DeckNode?
    
    init(size: CGSize, deck: Deck) {
        let deckNode = DeckNode(deck: deck, width: size.width)
        super.init(texture: SKTexture(image: UIImage(named: "Clear")!), color: .clear, size: size)
        
        isUserInteractionEnabled = true
        anchorPoint = CGPoint(x: 0, y: 1)
        
        let emptyNode = CardNode(card: Card(value: 0, color: UIColor.black.withAlphaComponent(0.1)), width: size.width)
        addChild(emptyNode)
        
        name = "Name\(Int.random(in: 0...1000))"
        add(deckNode: deckNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = deckNode?.deckDraggable {
            deckDragging = node
            node.drag(to: touch.location(in: node.parentNode ?? self))
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = deckDragging {
            node.move(to: touch.location(in: node.parentNode ?? self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let deckDragged = deckDragging {
            let pos = touches.first!.location(in: parent!)
            if let slotDragged = delegate?.getSlot(for: pos),
                slotDragged != self,
                move(deckDragged, to: slotDragged) {
//                let generator = UIImpactFeedbackGenerator(style: .heavy)
//                generator.impactOccurred()
                
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            } else {
                deckDragged.drop()
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
            }
        }
    }
    
    func move(_ deckNode: DeckNode, to slotNode: SlotNode) -> Bool {
        if deckNode == self.deckNode {
            self.deckNode = nil
        }
        
        let deckFit: Bool
        
        if let node = slotNode.deckNode {
            deckFit = deckNode.deck.card.isNext(of: node.deck.lastCard)
            deckNode.move(to: node)
            
        } else {
            deckNode.parentNode?.childNode = nil
            deckNode.parentNode = nil
            
            deckNode.deck.detach()
            
//            slotNode.add(deckNode: deckNode)
            deckNode.move(toParent: slotNode)
            slotNode.deckNode = deckNode
            deckNode.drop()
            deckFit = true
        }
        delegate?.update(movement: Movement(slotSource: self, slotDestination: slotNode, deckNode: deckNode))
        return deckFit
//        return deckNode.deck.card.value == slotNode.deckNode.
    }
    
    private func add(deckNode: DeckNode) {
        deckNode.position = .zero
        deckNode.zPosition = 1
        deckNode.move(toParent: self)
        self.deckNode = deckNode
    }
    
    func toString() -> String {
        """
        \(name!)
        \(deckNode?.toString() ?? "empty")
        """
    }
}
