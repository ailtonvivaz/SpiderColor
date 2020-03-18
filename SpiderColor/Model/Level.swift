//
//  Level.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 17/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

struct Level {
    let value: Int
    let colors: [UIColor]
    var completed: Bool = false
    var isAvailable: Bool = false
}
