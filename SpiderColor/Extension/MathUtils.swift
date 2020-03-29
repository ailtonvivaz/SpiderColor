//
//  MathUtils.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 27/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

/*
 Returns the Greatest Common Divisor of two numbers.
 */
func gcd(_ x: Int, _ y: Int) -> Int {
    var a = 0
    var b = max(x, y)
    var r = min(x, y)

    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    return b
}

/*
 Returns the least common multiple of two numbers.
 */
func lcm(_ x: Int, _ y: Int) -> Int {
    return x / gcd(x, y) * y
}
