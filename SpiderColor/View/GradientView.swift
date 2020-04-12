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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        update()
    }

    private func update() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = colors.map { $0.cgColor }
    }
}
