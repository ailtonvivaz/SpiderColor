//
//  SeededGenerator.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 12/04/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import GameplayKit

class SeededGenerator: RandomNumberGenerator {
    let seed: UInt64
    private let generator: GKMersenneTwisterRandomSource
    convenience init() {
        self.init(seed: 0)
    }

    init(seed: UInt64) {
        self.seed = seed
        generator = GKMersenneTwisterRandomSource(seed: seed)
    }

    func next<T>(upperBound: T) -> T where T: FixedWidthInteger, T: UnsignedInteger {
        return T(abs(generator.nextInt(upperBound: Int(upperBound))))
    }

    func next<T>() -> T where T: FixedWidthInteger, T: UnsignedInteger {
        return T(abs(generator.nextInt()))
    }
}
