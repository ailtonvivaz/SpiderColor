//
//  Game.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 17/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class Game: Codable {
    static let shared = Game.load() ?? Game()

    var levels: [Level]

    private init() {
        self.levels = [
            .init(value: 1, colors: [
                UIColor(displayP3Red: 0.95, green: 0.51, blue: 0.51, alpha: 1.0),
                UIColor(displayP3Red: 0.99, green: 0.89, blue: 0.54, alpha: 1.0)
            ], isAvailable: true),
            .init(value: 2, colors: [
                UIColor(displayP3Red: 0.38, green: 0.47, blue: 0.92, alpha: 1.0),
                UIColor(displayP3Red: 0.09, green: 0.92, blue: 0.85, alpha: 1.0)
            ]),
            .init(value: 3, colors: [
                UIColor(displayP3Red: 0.38, green: 0.15, blue: 0.45, alpha: 1.0),
                UIColor(displayP3Red: 0.77, green: 0.20, blue: 0.39, alpha: 1.0)
            ]),
            .init(value: 4, colors: [
                UIColor(displayP3Red: 0.44, green: 0.09, blue: 0.92, alpha: 1.0),
                UIColor(displayP3Red: 0.92, green: 0.38, blue: 0.38, alpha: 1.0)
            ]),
            .init(value: 5, colors: [
                UIColor(displayP3Red: 0.26, green: 0.9, blue: 0.58, alpha: 1.0),
                UIColor(displayP3Red: 0.23, green: 0.7, blue: 0.72, alpha: 1.0)
            ]),
            .init(value: 6, colors: [
                UIColor(displayP3Red: 0.4, green: 0.47, blue: 0.61, alpha: 1.0),
                UIColor(displayP3Red: 0.37, green: 0.15, blue: 0.39, alpha: 1.0)
            ]),
            .init(value: 7, colors: [
                UIColor(displayP3Red: 0.09, green: 0.31, blue: 0.41, alpha: 1.0),
                UIColor(displayP3Red: 0.34, green: 0.79, blue: 0.52, alpha: 1.0)
            ]),
            .init(value: 8, colors: [
                UIColor(displayP3Red: 0.11, green: 0.81, blue: 0.87, alpha: 1.0),
                UIColor(displayP3Red: 0.36, green: 0.14, blue: 0.48, alpha: 1.0)
            ]),
            .init(value: 9, colors: [
                UIColor(displayP3Red: 0.96, green: 0.31, blue: 0.64, alpha: 1.0),
                UIColor(displayP3Red: 1.0, green: 0.46, blue: 0.46, alpha: 1.0)
            ])
        ]
    }

    private static func load() -> Game? {
        if let savedGame = UserDefaults.standard.object(forKey: "game") as? Data {
            let decoder = JSONDecoder()
            if let loadedGame = try? decoder.decode(Game.self, from: savedGame) {
                return loadedGame
            }
        }
        return nil
    }

    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "game")
        }
    }

    func complete(level: Level) {
        if let index = levels.firstIndex(where: { level.value == $0.value }) {
            levels[index].completed = true

            if index < levels.count - 2 {
                levels[index].isAvailable = true
            }

            save()
        }
    }
}
