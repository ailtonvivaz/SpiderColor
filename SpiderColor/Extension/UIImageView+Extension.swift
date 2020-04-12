//
//  UIImageView+Extension.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 11/04/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

extension UIImageView {
    func rotate(duration: CFTimeInterval = 1, repeatCount: Float = .greatestFiniteMagnitude, completion: @escaping (() -> Void) = {}) {
        CATransaction.begin()
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.repeatCount = repeatCount
        CATransaction.setCompletionBlock(completion)
        self.layer.add(rotation, forKey: "rotationAnimation")
        CATransaction.commit()
    }
}
