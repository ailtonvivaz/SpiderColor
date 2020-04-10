//
//  Level.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 17/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class Level: Codable {
    let value: Int
    private let codableColors: [CodableColor]
    let qtyCards: Int
    var completed: Bool = false
    var isAvailable: Bool = false
    var focused: Bool = false

    var colors: [UIColor] { codableColors.map { $0.color } }

    internal init(value: Int, colors: [UIColor], qtyCards: Int, completed: Bool = false, isAvailable: Bool = false) {
        self.value = value
        self.qtyCards = qtyCards
        self.codableColors = colors.map { CodableColor(color: $0) }
        self.completed = completed
        self.isAvailable = isAvailable
    }

    init(value: Int, color: UIColor, angle: Int, qtyCards: Int) {
        self.value = value
        self.qtyCards = qtyCards
        self.codableColors = [color, color.withHueOffset(offset: CGFloat(angle) / 360)].map { CodableColor(color: $0) }
        self.isAvailable = true
    }
}
