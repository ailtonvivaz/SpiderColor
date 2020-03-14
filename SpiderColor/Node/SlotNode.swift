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
    
    init(size: CGSize, deck: Deck) {
        let deckNode = DeckNode(deck: deck, width: size.width)
        super.init(texture: SKTexture(image: UIImage(named: "Clear")!), color: .clear, size: size)
        
        isUserInteractionEnabled = true
        anchorPoint = CGPoint(x: 0, y: 1)
        
        name = "Name\(Int.random(in: 0...1000))"
        add(deckNode: deckNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = deckNode?.deckDraggable {
            node.drag(to: touch.location(in: node.parentNode ?? self))
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = deckNode?.deckDraggable {
            node.move(to: touch.location(in: node.parentNode ?? self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let deckDragged = deckNode?.deckDraggable {
            let pos = touches.first!.location(in: parent!)
            if let slotDragged = delegate?.getSlot(for: pos),
                slotDragged != self,
                move(deckDragged, to: slotDragged) {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            } else {
                deckDragged.drop()
            }
        }
    }
    
    func move(_ deckNode: DeckNode, to slotNode: SlotNode) -> Bool {
        if deckNode == self.deckNode {
            self.deckNode = nil
        }
        if let node = slotNode.deckNode {
            deckNode.move(to: node)
        } else {
            deckNode.parentNode?.childNode = nil
            deckNode.parentNode = nil
            
            deckNode.deck.detach()
            
//            slotNode.add(deckNode: deckNode)
            deckNode.move(toParent: slotNode)
            slotNode.deckNode = deckNode
            deckNode.drop()
        }
        delegate?.update(movement: Movement(slotSource: self, slotDestination: slotNode, deckNode: deckNode))
        return true
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
