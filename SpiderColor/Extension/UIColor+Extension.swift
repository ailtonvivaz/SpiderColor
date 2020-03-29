//
//  UIColor+Extension.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 05/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIColor {
    struct HSBA {
        let h: CGFloat
        let s: CGFloat
        let b: CGFloat
        let a: CGFloat
    }

    struct RGBA {
        let r: CGFloat
        let g: CGFloat
        let b: CGFloat
        let a: CGFloat
    }

    var hsba: HSBA {
        var (h, s, b, a) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return HSBA(h: h, s: s, b: b, a: a)
    }

    var rgba: RGBA {
        var (r, g, b, a) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return RGBA(r: r, g: g, b: b, a: a)
    }

    func withHueOffset(offset: CGFloat) -> UIColor {
        if offset == 0 { return self }
        return UIColor(hue: fmod(hsba.h + offset, 1), saturation: hsba.s, brightness: hsba.b, alpha: hsba.a)
    }

    func withSaturationOffset(offset: CGFloat) -> UIColor {
        if offset == 0 { return self }
        return UIColor(hue: hsba.h, saturation: (hsba.s + offset).truncatingRemainder(dividingBy: 1), brightness: hsba.b, alpha: hsba.a)
    }

    func withBrightnessOffset(offset: CGFloat) -> UIColor {
        if offset == 0 { return self }
        return UIColor(hue: hsba.h, saturation: hsba.s, brightness: (min(hsba.b, 1.0) + offset).truncatingRemainder(dividingBy: 1), alpha: hsba.a)
    }
}

extension UIColor {
    static func +(color1: UIColor, color2: UIColor) -> UIColor {
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))

        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        // add the components, but don't let them go above 1.0
        return UIColor(red: min(r1 + r2, 1), green: min(g1 + g2, 1), blue: min(b1 + b2, 1), alpha: (a1 + a2) / 2)
    }

    static func *(color: UIColor, multiplier: CGFloat) -> UIColor {
        var (r, g, b, a) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r * multiplier, green: g * multiplier, blue: b * multiplier, alpha: a)
    }

    static func *(color1: UIColor, color2: UIColor) -> UIColor {
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        return UIColor(red: r1 * r2, green: g1 * g2, blue: b1 * b2, alpha: a1 * a2)
    }

    static var random: UIColor {
        UIColor(displayP3Red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
    }

    func mix(with color: UIColor, percent: CGFloat = 0.5) -> UIColor {
        return (self * (1.0 - percent)) + (color * percent)
    }
}

extension Array where Element == UIColor {
    func generateGradient(of quantity: Int) -> [UIColor] {
//        let middles = quantity - 2
        let factor = 1.0 / CGFloat(quantity - 1)

        let color = self[0]
        var colors: [UIColor] = []
        for i in 1..<count {
            let nextColor = self[i]

            for i in 0..<quantity {
                let percent = CGFloat(i) * factor
                let interColor = color.mix(with: nextColor, percent: percent)
                colors.append(interColor)
            }

//            colors.append(nextColor)
        }

        return colors
    }
}
