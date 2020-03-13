//
//  Movement.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 13/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

class Movement {
    var slotSource: SlotNode
    var slotDestination: SlotNode
    var deckNode: DeckNode

    init(slotSource: SlotNode, slotDestination: SlotNode, deckNode: DeckNode) {
        self.slotSource = slotSource
        self.slotDestination = slotDestination
        self.deckNode = deckNode
    }
}
