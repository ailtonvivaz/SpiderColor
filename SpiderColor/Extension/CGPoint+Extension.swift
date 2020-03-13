//
//  CGPoint+Extension.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 11/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    static func +(point1: CGPoint, point2: CGPoint) -> CGPoint {
        CGPoint(x: point1.x + point2.x, y: point1.y + point2.y)
    }

    static func -(point1: CGPoint, point2: CGPoint) -> CGPoint {
        CGPoint(x: point1.x - point2.x, y: point1.y - point2.y)
    }

    static func *(point1: CGPoint, multiplier: CGFloat) -> CGPoint {
        CGPoint(x: point1.x * multiplier, y: point1.y * multiplier)
    }
}
