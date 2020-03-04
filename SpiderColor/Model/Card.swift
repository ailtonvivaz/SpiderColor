//
//  Card.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation
import UIKit

struct Card {
    static var empty = Card(color: .clear)

    var color: UIColor
}

extension Card: Comparable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color
    }

    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color
    }
}
