//
//  Ads.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 19/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

class Ads {
    static var gameBanner: String {
        #if DEBUG
            return "ca-app-pub-3940256099942544/2934735716"
        #else
            return "ca-app-pub-8446667675243761/2673418468"
        #endif
    }
}
