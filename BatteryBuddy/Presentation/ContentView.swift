//
//  ContentView.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 9/30/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: BatteryStateViewModel
    let batteryUseCases = BatteryUseCases()
    let notificationUseCases = NotificationUseCases()

    var body: some View {
        VStack {
            Text("电池电量: \(vm.batteryInfo.batteryLevel, specifier: "%.1f")%")
            Text("充电状态: \(vm.batteryInfo.isCharging ? "正在充电" : "未充电")")

            Button("发送测试通知") {
                notificationUseCases.sendNotification(
                    title: "电池状态",
                    body: "当前电量: \(vm.batteryInfo.batteryLevel)%"
                )
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BatteryStateViewModel())
}
