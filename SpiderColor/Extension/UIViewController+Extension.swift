//
//  UIViewController+Extension.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 18/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
