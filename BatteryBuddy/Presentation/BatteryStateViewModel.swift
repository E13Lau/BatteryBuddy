//
//  BatteryStateViewModel.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

import Combine
import Foundation

class BatteryStateViewModel: ObservableObject {
    @Published var isMonitoring: Bool = false
    @Published var batteryInfo: BatteryInfo = .init(batteryLevel: 0, isCharging: false)

    private var timer: Timer?

    private let batteryUseCases = BatteryUseCases()
    private let batteryNotifyUseCases = BatteryNotifyUseCases(
        notificationUseCases: NotificationUseCases())
    private let notificationUseCases: AnyNotificationUseCases = NotificationUseCases()
    private var cancellables = Set<AnyCancellable>()
    
    private var autoLaunch: Bool {
        return UserDefaults.standard.bool(forKey: "autoLaunch")
    }

    init() {
        updateBatteryInfo()
        
        requestNotificationPermission()
        
        if autoLaunch {
            startAction()
        }
    }

    deinit {
        stopMonitoring()
    }

    func toggleAction() {
        if isMonitoring {
            stopAction()
        } else {
            startAction()
        }
    }

    func startAction() {
        setupSubscriptions()
        startMonitoring()
    }

    func stopAction() {
        cancelSubscriptions()
        stopMonitoring()
    }

    func requestNotificationPermission() {
        notificationUseCases.requestNotificationPermission { granted, error in
            if granted {
                print("通知权限已获得")
            } else if let error = error {
                print("请求通知权限时出错: \(error.localizedDescription)")
            }
        }
    }
}

extension BatteryStateViewModel {

    private func cancelSubscriptions() {
        cancellables.forEach({ $0.cancel() })
        cancellables = []
    }

    private func setupSubscriptions() {

        let min = UserDefaults.standard.double(forKey: "lowerBound")
        let max = UserDefaults.standard.double(forKey: "upperBound")

        $batteryInfo
            .withPreviousValue()
            .sink { [weak self] oldValue, newValue in
                self?.handleBatteryInfoChange(
                    oldValue: oldValue, newValue: newValue, min: min, max: max)
            }
            .store(in: &cancellables)
    }

    private func startMonitoring() {
        guard isMonitoring == false else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateBatteryInfo()
            }
        }
        isMonitoring = true
    }

    private func stopMonitoring() {
        timer?.invalidate()
        timer = nil
        isMonitoring = false
    }

    private func updateBatteryInfo() {
        let batteryInfo = batteryUseCases.fetchBatteryInfo()
        self.batteryInfo = batteryInfo
    }

    private func handleBatteryInfoChange(
        oldValue: BatteryInfo?, newValue: BatteryInfo, min: Double, max: Double
    ) {
        print("旧电池电量: \(oldValue?.batteryLevel ?? 0)，新电池电量: \(newValue.batteryLevel)")
        print(
            "旧充电状态: \(oldValue?.isCharging ?? false ? "正在充电" : "未充电")，新充电状态: \(newValue.isCharging ? "正在充电" : "未充电")"
        )

        guard let oldValue else { return }

        let batteryNotify = batteryNotifyUseCases.shouldNotify(
            old: oldValue, new: newValue, min: min, max: max)
        if batteryNotify.shouldNotify {
            batteryNotifyUseCases.sendNotify(notify: batteryNotify)
        }
    }

}
