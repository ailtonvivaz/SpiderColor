//
//  Deck.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

class Deck {
    private(set) var card: Card
    private(set) var childDeck: Deck?
    private(set) var parentDeck: Deck?

    static var empty = Deck(card: .empty)

    var lastCard: Card {
        if let deck = childDeck {
            return deck.lastCard
        }
        return card
    }

    var firstParent: Deck {
        if let deck = parentDeck {
            return deck.firstParent
        }
        return self
    }

    var size: Int {
        if let deck = childDeck {
            return 1 + deck.size
        } else { return 1 }
    }

    var isDraggable: Bool {
        if let deck = childDeck {
            return (card > deck.card) && deck.isDraggable
        }
        return true && card != .empty
    }

    init(card: Card) {
        self.card = card
    }

    init(cards: [Card]) {
        self.card = cards[0]
        var deck = self
        for i in 1..<cards.count {
            deck = deck.with(card: cards[i])
        }
    }

    func with(card: Card) -> Deck {
        with(deck: Deck(card: card))
    }

    func with(deck: Deck) -> Deck {
        if childDeck != nil {
            _ = childDeck?.with(deck: deck)
        } else {
            childDeck = deck
            childDeck?.parentDeck = self
        }
        return self
    }

    func change(to deck: Deck) {
        if let parentDeck = parentDeck {
            parentDeck.childDeck = nil
            _ = deck.with(deck: self)
        }
    }
}
