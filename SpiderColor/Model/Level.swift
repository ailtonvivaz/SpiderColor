//
//  Level.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 17/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class Level {
    let value: Int
    let qtyCards: Int
    var completed: Bool = false
    var isAvailable: Bool = false
    var focused: Bool = false
    var colors: [UIColor]

    var cards: [Card] {
        let colors: [UIColor] = self.colors.generateGradient(of: qtyCards)
        return colors.enumerated().map { Card(value: $0, color: $1) }
    }

    internal init(value: Int, colors: [UIColor], qtyCards: Int, completed: Bool = false, isAvailable: Bool = false) {
        self.value = value
        self.qtyCards = qtyCards
        self.colors = colors
        self.completed = completed
        self.isAvailable = isAvailable
    }
}
