//
//  BInaryInteger+Extension.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 29/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

extension BinaryInteger {
    var binaryDescription: String {
        var binaryString = ""
        var internalNumber = self
        
        for _ in 1...bitWidth {
            binaryString.insert(contentsOf: "\(internalNumber & 1)", at: binaryString.startIndex)
            internalNumber >>= 1
        }

        return binaryString
    }
}
