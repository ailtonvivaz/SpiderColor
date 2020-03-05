//
//  UIColor+Extension.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 05/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

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
        
        print(factor)

        let color = self[0]
        var colors: [UIColor] = []
        for i in 1..<self.count {
            let nextColor = self[i]

            for i in 0..<quantity {
                let percent = CGFloat(i) * factor
                let interColor = color.mix(with: nextColor, percent: percent)
                colors.append(interColor)
                
                print(i, percent)
            }

//            colors.append(nextColor)
        }

        return colors
    }
}
