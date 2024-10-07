//
//  BatteryUseCases.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/2/24.
//

import Foundation
import IOKit.ps

struct BatteryUseCases {
    func fetchBatteryInfo() -> BatteryInfo {
        var batteryLevel: Double = 0.0
        var isCharging: Bool = false

        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array

        for ps in sources {
            let info =
                IOPSGetPowerSourceDescription(snapshot, ps).takeUnretainedValue() as! [String: Any]

            if let capacity = info[kIOPSCurrentCapacityKey] as? Int,
                let maxCapacity = info[kIOPSMaxCapacityKey] as? Int
            {
                batteryLevel = Double(capacity) / Double(maxCapacity) * 100.0
            }

            if let chargingState = info[kIOPSPowerSourceStateKey] as? String {
                isCharging = chargingState == kIOPSACPowerValue
            }
        }

        return BatteryInfo(batteryLevel: batteryLevel, isCharging: isCharging)
    }

}
