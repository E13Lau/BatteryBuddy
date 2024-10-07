//
//  DefaultKeyValueStorage.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

import Foundation

struct DefaultKeyValueStorage: AnyKeyValueStorage {
        
    private let userDefaults: UserDefaults
    
    private let namespace: String
    
    init(namespace: String) {
        self.namespace = namespace
        self.userDefaults = UserDefaults.init(suiteName: namespace) ?? UserDefaults.standard
    }
    
    func get<T>(key: String) -> T? {
        userDefaults.object(forKey: "\(namespace)" + key) as? T
    }
    
    func set<T>(key: String, value: T) -> Bool {
        userDefaults.set(value, forKey: "\(namespace)" + key)
        return true
    }
    
    func delete(key: String) -> Bool {
        userDefaults.set(nil, forKey: "\(namespace)" + key)
        return true
    }
    
    func clean() {
        userDefaults.removePersistentDomain(forName: namespace)
    }
    
}
