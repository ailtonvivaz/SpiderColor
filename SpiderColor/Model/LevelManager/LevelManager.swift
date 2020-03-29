//
//  LevelManager.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 29/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

protocol LevelManager {
    func getLevel(_ level: Int) -> Level
}
