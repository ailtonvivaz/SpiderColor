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

    static var empty: Deck { Deck(card: Card(value: -1, color: .clear)) }

    var isEmpty: Bool { card.value == -1 }

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
            return (card.isNext(of: deck.card)) && deck.isDraggable
        }
        return !isEmpty
    }

    init(card: Card) {
        self.card = card
    }

    init(cards: [Card]) {
        self.card = cards[0]
        var deck = self
        for i in 1..<cards.count {
            deck = deck.add(card: cards[i])
        }
    }

    func add(card: Card) -> Deck {
        add(deck: Deck(card: card))
    }

    func add(deck: Deck) -> Deck {
        if childDeck != nil {
            _ = childDeck?.add(deck: deck)
        } else {
            childDeck = deck
            childDeck?.parentDeck = self
        }
        return self
    }

    func move(to deck: Deck) {
        if let parentDeck = parentDeck {
            parentDeck.childDeck = nil
            self.parentDeck = nil
            _ = deck.add(deck: self)
        }
    }
}
