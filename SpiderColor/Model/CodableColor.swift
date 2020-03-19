//
//  CodableColor.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 19/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

/// Allows you to use Swift encoders and decoders to process UIColor
public struct CodableColor {
    /// The color to be (en/de)coded
    let color: UIColor
}

extension CodableColor: Encodable {
    public func encode(to encoder: Encoder) throws {
        let nsCoder = NSKeyedArchiver(requiringSecureCoding: true)
        color.encode(with: nsCoder)
        var container = encoder.unkeyedContainer()
        try container.encode(nsCoder.encodedData)
    }
}

extension CodableColor: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let decodedData = try container.decode(Data.self)
        let nsCoder = try NSKeyedUnarchiver(forReadingFrom: decodedData)
        self.color = UIColor(coder: nsCoder)!
    }
}

public extension UIColor {
    func codable() -> CodableColor {
        return CodableColor(color: self)
    }
}
