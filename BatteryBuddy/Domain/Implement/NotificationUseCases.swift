//
//  BatteryNotifyUseCases.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

import Foundation
import UserNotifications

struct NotificationUseCases: AnyNotificationUseCases {
    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString, content: content, trigger: nil)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("发送通知时出错: \(error.localizedDescription)")
            }
        }
    }

    func requestNotificationPermission(completion: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound], completionHandler: completion)
    }
}
