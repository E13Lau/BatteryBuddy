//
//  ConfigureUseCases.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

import Foundation

struct ConfigureUseCases {
    private let storage: AnyKeyValueStorage

    init(storage: AnyKeyValueStorage) {
        self.storage = storage
    }

    func getConfigure() -> Configure {
        let min = storage.get(key: "min") as Double? ?? 20.0
        let max = storage.get(key: "max") as Double? ?? 80.0
        let autoStartWhenLaunch = storage.get(key: "autoStartWhenLaunch") as Bool? ?? false

        return Configure(min: min, max: max, autoStartWhenLaunch: autoStartWhenLaunch)
    }

    func saveConfigure(_ configure: Configure) -> Bool {
        var success = true

        success = success && storage.set(key: "min", value: configure.min)
        success = success && storage.set(key: "max", value: configure.max)
        success =
            success && storage.set(key: "autoStartWhenLaunch", value: configure.autoStartWhenLaunch)

        return success
    }

    func updateMin(_ min: Double) -> Bool {
        storage.set(key: "min", value: min)
    }

    func updateMax(_ max: Double) -> Bool {
        storage.set(key: "max", value: max)
    }

    func updateAutoStartWhenLaunch(_ autoStart: Bool) -> Bool {
        storage.set(key: "autoStartWhenLaunch", value: autoStart)
    }

    func resetToDefault() -> Bool {
        let defaultConfigure = Configure(min: 20.0, max: 80.0, autoStartWhenLaunch: false)
        return saveConfigure(defaultConfigure)
    }
}
