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
        if let touch = touches.first {
            deckNode?.deckDraggable?.drag(to: touch.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            deckNode?.deckDraggable?.move(to: touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let deckDragged = deckNode?.deckDraggable {
            let pos = touches.first!.location(in: parent!)
            if let slotDragged = delegate?.getSlot(for: pos), slotDragged != self {
//                print("end in \(pos) \n \(slotDragged)")
                deckDragged.drop()
                move(deckDragged, to: slotDragged)
//                slotDragged.add(deckNode: deckDragged)
            } else {
                deckDragged.drop()
            }
        }
    }
    
    private func move(_ deckNode: DeckNode, to slotNode: SlotNode) -> Bool {
        if deckNode == self.deckNode {
            self.deckNode = nil
        }
        
        if let node = slotNode.deckNode {
            deckNode.move(to: node)
        } else {
            slotNode.add(deckNode: deckNode)
        }
        
//        if let node = self.deckNode {
//            if deckNode == node {
//                self.deckNode = nil
//            }
//            deckNode.move(to: node)
//        } else {
//            deckNode.position = .zero
//            deckNode.zPosition = 0
//            deckNode.move(toParent: self)
//            self.deckNode = deckNode
//        }
        return true
    }
    
    private func add(deckNode: DeckNode) {
        deckNode.position = .zero
        deckNode.zPosition = 0
        deckNode.move(toParent: self)
        self.deckNode = deckNode
    }
}
