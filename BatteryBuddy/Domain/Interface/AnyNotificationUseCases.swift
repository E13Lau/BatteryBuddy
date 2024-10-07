//
//  AnyNotificationUseCases.swift
//  BatteryBuddy
//
//  Created by Jay Lau on 10/5/24.
//

import Foundation

protocol AnyNotificationUseCases {
    func sendNotification(title: String, body: String)
    func requestNotificationPermission(completion: @escaping (Bool, Error?) -> Void)
}
