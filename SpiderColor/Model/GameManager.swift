//
//  GameManager.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 17/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class GameManager: Codable {
    static let shared = load() ?? GameManager()
    let levelManager = ClassicLevelManager()

    var dataLevels: [LevelData] = []
    var lastValueLevelCompleted: Int { dataLevels.last(where: \.completed)?.level ?? 0 }
    var lastLevelCompleted: Level { levelManager.getLevel(lastValueLevelCompleted) }
    var lastPageCompleted: Int { lastValueLevelCompleted / 9 }
    var pages: Int { min(lastPageCompleted + 2, maxPages) }
    private let maxPages = (256 / 9) + 1

    enum CodingKeys: String, CodingKey {
        case dataLevels
    }

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

    private func getLevel(of level: Int) -> Level { levelManager.getLevel(level) }

    func levelsFor(page: Int) -> [Level] {
        var levels = [Level]()

        for i in 0..<9 {
            let valueLevel = 9 * page + i + 1
            if valueLevel > 255 { break }
            let level = getLevel(of: valueLevel)
            level.completed = dataLevels
                .filter(\.completed)
                .map(\.level)
                .contains(valueLevel)
            level.isAvailable = lastValueLevelCompleted + 1 >= valueLevel
            level.focused = valueLevel == lastValueLevelCompleted + 1
            levels.append(level)
        }

        return levels
    }

    private static func load() -> GameManager? {
        if let savedGame = UserDefaults.standard.object(forKey: "game") as? Data {
            let decoder = JSONDecoder()
            if let loadedGame = try? decoder.decode(GameManager.self, from: savedGame) {
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
        if let index = dataLevels.firstIndex(where: { $0.level == level.value }) {
            dataLevels[index].completed = true
        } else {
            dataLevels.append(LevelData(level: level.value, completed: true))
        }
        save()
    }
}
