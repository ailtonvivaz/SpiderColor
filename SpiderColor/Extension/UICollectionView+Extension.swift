//
//  UICollectionView+Extension.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 16/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerFromNib<T: UICollectionViewCell>(_ clazz: T.Type) {
        self.register(UINib(nibName: "\(clazz)", bundle: nil), forCellWithReuseIdentifier: "\(clazz)")
    }

    func dequeueReusableCellFromNib<T: UICollectionViewCell>(_ clazz: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: "\(clazz)", for: indexPath) as? T
    }
}
