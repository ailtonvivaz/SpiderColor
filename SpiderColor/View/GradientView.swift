//
//  GradientView.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 16/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class GradientView: UIView {
    var colors: [UIColor] = [] {
        didSet {
            update()
        }
    }

    open override class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        update()
    }

    private func update() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = colors.map { $0.cgColor }
    }
}
