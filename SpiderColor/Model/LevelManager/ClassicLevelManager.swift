//
//  ClassicLevelManager.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 29/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class ClassicLevelManager: LevelManager {
    private struct RGB {
        var r: Int
        var g: Int
        var b: Int
    }

    func getLevel(_ level: Int) -> Level {
        let colors = [getColor(of: level), getColor(of: level + 1)]

        return Level(value: level, colors: colors, qtyCards: getQtyFor(level: level))
    }

    private func getQtyFor(level: Int) -> Int {
        var level = level
        var qty = 5

        var i = 0
        while true {
            level -= 3 * (i + 1)
            print(level)
            if level <= 0 || qty == 27 { break }
            i += 1
            qty += 2
        }
        return qty
    }

    private func revBit(of value: Int) -> Int {
        let binStr = UInt8(value).binaryDescription
        let invBinStr = String(binStr.reversed())
        return Int(invBinStr, radix: 2)!
    }

    private func powerBit(of value: Int) -> Int { value | 0x80 }

    private func getColor(of level: Int) -> UIColor {
        if level == 1 { return .black }

        let level = level - 1
        let mod = level % 6
        let rgb: RGB

        switch mod {
            case 0:
                rgb = RGB(r: level, g: revBit(of: level), b: powerBit(of: level))
            case 1:
                rgb = RGB(r: powerBit(of: level), g: level, b: revBit(of: level))
            case 2:
                rgb = RGB(r: level, g: powerBit(of: level), b: revBit(of: level))
            case 3:
                rgb = RGB(r: revBit(of: level), g: level, b: powerBit(of: level))
            case 4:
                rgb = RGB(r: powerBit(of: level), g: revBit(of: level), b: level)
            case 5:
                rgb = RGB(r: revBit(of: level), g: powerBit(of: level), b: level)
            default:
                rgb = RGB(r: 0, g: 0, b: 0)
        }

        print("level", level, rgb)
        return UIColor(red: rgb.r, green: rgb.g, blue: rgb.b)
    }
}
