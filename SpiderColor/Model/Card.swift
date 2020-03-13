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
    var value: Int
    var color: UIColor
    
    func isNext(of other: Card) -> Bool {
        value + 1 == other.value
    }
}

extension Card: Comparable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.value == rhs.value
    }

    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.value < rhs.value
    }
}
