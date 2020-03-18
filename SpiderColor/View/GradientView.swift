//
//  GradientView.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 16/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

//@IBDesignable
class GradientView: UIView {
    @IBInspectable
    var startColor: UIColor = .white

    @IBInspectable
    var endColor: UIColor = .black

    open override class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        update()
    }

    override func layoutSubviews() {
        update()
        startColor = .random
        endColor = .random
    }

    private func update() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
