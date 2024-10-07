//
//  AnyKeyValueStorage.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

protocol AnyKeyValueStorage {
    func get<T>(key: String) -> T?
    func set<T>(key: String, value: T) -> Bool
    func delete(key: String) -> Bool
    
    func clean()

}
