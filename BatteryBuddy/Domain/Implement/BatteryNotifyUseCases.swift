//
//  BatteryNotifyUseCases.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

struct BatteryNotifyUseCases {
    
    let notificationUseCases: AnyNotificationUseCases
    
    func shouldNotify(old: BatteryInfo, new: BatteryInfo, min: Double, max: Double) -> BatteryNotify {
        // 检查充电状态变化
        if old.isCharging != new.isCharging {
            let status = new.isCharging ? "开始充电" : "停止充电"
            return BatteryNotify(shouldNotify: true, message: "电池状态变化：\(status)")
        }

        // 检查电量是否达到或低于阈值
        if new.isCharging {
            if old.batteryLevel < max && new.batteryLevel >= max {
                return BatteryNotify(shouldNotify: true, message: "电池电量已达到\(Int(max))%，可以拔掉充电器")
            }
        } else {
            if old.batteryLevel > min && new.batteryLevel <= min {
                return BatteryNotify(shouldNotify: true, message: "电池电量已降至\(Int(min))%，请及时充电")
            }
        }

        // 如果没有满足上述条件，则不需要通知
        return BatteryNotify(shouldNotify: false, message: nil)
    }
    
    func sendNotify(notify: BatteryNotify) {
        notificationUseCases.sendNotification(title: "BatteryBuddy", body: notify.message ?? "")
    }
}
