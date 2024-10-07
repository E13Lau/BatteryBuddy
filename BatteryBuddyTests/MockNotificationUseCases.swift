//
//  MockNotificationUseCases.swift
//  BatteryBuddyTests
//
//  Created by Jay Lau on 10/5/24.
//

import Foundation

struct MockNotificationUseCases: AnyNotificationUseCases {
    func sendNotification(title: String, body: String) {
        
    }
    
    func requestNotificationPermission(completion: @escaping (Bool, (any Error)?) -> Void) {
        completion(true, nil)
    }
    
}
