//
//  ExtralContentView.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 9/30/24.
//

import SwiftUI

struct ExtralContentView: View {
    /// 监听最小值
    @AppStorage("lowerBound") private var lowerBound: Double = 20.0
    /// 监听最大值
    @AppStorage("upperBound") private var upperBound: Double = 80.0
    /// APP启动后自动开始监控
    @AppStorage("autoLaunch") private var autoLaunch: Bool = false

    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var vm: BatteryStateViewModel

    private var isSliderAvailable: Binding<Bool> {
        Binding(
            get: { !self.vm.isMonitoring },
            set: { self.vm.isMonitoring = !$0 }
        )
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(
                "范围: \(Int(lowerBound)) - \(Int(upperBound)) 当前电量\(Int(vm.batteryInfo.batteryLevel))"
            )

            RangeSliderView(
                lowerBound: $lowerBound, upperBound: $upperBound, isAvailable: isSliderAvailable
            )
            .padding(.horizontal, 40)
            .frame(width: 300, height: 80)
            .offset(x: -10, y: 15)

            Text(
                "启动后： \n 1. 充电时，当电池电量达到\(Int(upperBound))%发出提醒 \n 2. 耗电时，当电池电量低到\(Int(lowerBound))%发出提醒"
            )
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            
            Toggle(isOn: $autoLaunch) {
                Text("APP启动后自动开始监控")
            }

            HStack {
                Button("退出") {
                    NSApplication.shared.terminate(nil)
                }
                .foregroundColor(.red)

                Spacer()

                if vm.isMonitoring {
                    Text("运行中...")
                }

                Button(vm.isMonitoring ? "停止" : "启动") {
                    vm.toggleAction()
                }
                .foregroundColor(vm.isMonitoring ? .red : .blue)
                .buttonStyle(BorderedButtonStyle())
            }
        }
        .frame(width: 300)
        .padding()
    }
}

#Preview {
    ExtralContentView()
        .environmentObject(BatteryStateViewModel())
}
