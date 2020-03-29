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
            return "ca-app-pub-6710438178084678/3383643130"
        #endif
    }

    static var interLevel: String {
        #if DEBUG
            return "ca-app-pub-3940256099942544/4411468910"
        #else
            return "ca-app-pub-6710438178084678/4313581424"
        #endif
    }
}
