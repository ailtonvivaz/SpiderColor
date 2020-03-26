//
//  Game.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 17/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class Game: Codable {
    static let shared = load() ?? Game()

    var dataLevels: [LevelData] = []

    private init() {}

    private func getQtyFor(level: Int) -> Int {
        var level = level
        var qty = 5

        var i = 0
        while true {
            level -= 3 * (i + 1)
            print(level)
            if level <= 0 || qty == 27 { break }
            i += 1
            qty += 2
        }
        return qty
    }

//    private func getLevel(of level: Int) -> Level {
//
//    }

    func levelsFor(page: Int) -> [Level] {
        var levels = [Level]()

        var valueLevel = 9 * page
        for i in 0...2 {
            for cor in [UIColor.red, UIColor.blue, UIColor.green] {
                valueLevel += 1
                let level = Level(value: valueLevel, color: cor, angle: 240 - i * 45, qtyCards: getQtyFor(level: valueLevel))
                level.completed = dataLevels.map(\.level).contains(valueLevel)
                level.isAvailable = (dataLevels.last(where: \.completed)?.level ?? 0) + 1 >= valueLevel
                levels.append(level)
            }
        }

        return levels
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
        if let index = dataLevels.firstIndex(where: {$0.level == level.value}) {
            dataLevels[index].completed = true
        } else {
            dataLevels.append(LevelData(level: level.value, completed: true))
        }
        save()
    }
}
