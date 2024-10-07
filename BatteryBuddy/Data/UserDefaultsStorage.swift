//
//  UserDefaultsStorage.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

import Foundation

class UserDefaultsStorage: AnyKeyValueStorage {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func get<T>(key: String) -> T? {
        userDefaults.object(forKey: key) as? T
    }

    func set<T>(key: String, value: T) -> Bool {
        userDefaults.set(value, forKey: key)
        return true
    }

    func delete(key: String) -> Bool {
        userDefaults.removeObject(forKey: key)
        return true
    }

    func clean() {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }
}
