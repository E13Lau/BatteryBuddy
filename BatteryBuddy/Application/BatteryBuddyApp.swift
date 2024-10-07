//
//  BatteryBuddyApp.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 9/30/24.
//

//
//  BatteryBuddyApp.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

import SwiftUI
import UserNotifications

@main
struct BatteryBuddyApp: App {
    @StateObject private var vm = BatteryStateViewModel()

    var body: some Scene {
        MenuBarExtra {
            ExtralContentView()
                .environmentObject(vm)
        } label: {
            Image("MenuBarExtraIcon", bundle: nil)
        }
        .menuBarExtraStyle(.window)
    }
}
