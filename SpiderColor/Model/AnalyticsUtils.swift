//
//  AnalyticsUtils.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 19/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import FirebaseAnalytics

class AnalyticsUtils {
    static func tapButton(_ id: String) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterContentType: "button",
            AnalyticsParameterItemID: id,
        ])
    }

    static func startLevel(_ level: Int) {
        Analytics.logEvent("start_level", parameters: [
            AnalyticsParameterLevel: level,
        ])
    }

    static func endLevel(_ level: Int, time: UInt) {
        Analytics.logEvent("end_level", parameters: [
            AnalyticsParameterLevel: level,
            "time": time
        ])
    }
}
