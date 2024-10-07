//
//  MockKeyValueStorage.swift
//  BatteryBuddyTests
//
//  Created by Jay Lau on 10/5/24.
//

import Foundation

// 模拟 AnyKeyValueStorage 的实现，用于测试
class MockKeyValueStorage: AnyKeyValueStorage {
    private var storage: [String: Any] = [:]

    func get<T>(key: String) -> T? {
        return storage[key] as? T
    }

    func set<T>(key: String, value: T) -> Bool {
        storage[key] = value
        return true
    }

    func delete(key: String) -> Bool {
        storage.removeValue(forKey: key)
        return true
    }

    func clean() {
        storage.removeAll()
    }
}
