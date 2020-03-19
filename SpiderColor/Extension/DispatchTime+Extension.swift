//
//  DispatchTime+Extension.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 19/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

extension DispatchTime {
    static var nowInSeconds: UInt { now().getUptimeSeconds() }

    func getUptimeSeconds() -> UInt {
        return UInt(uptimeNanoseconds / UInt64(1E9))
    }
}
