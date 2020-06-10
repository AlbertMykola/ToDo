//
//  Notification push.swift
//  ToDo
//
//  Created by Albert on 22.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import Foundation
import UserNotifications

func notificationPush(InTime time: Date, identifier: String, text: String, completion:(Bool) -> ()) {
    removeNotificationCenter(withIdentifier: [identifier])
    
    let content = UNMutableNotificationContent()
    content.title = "Todo List"
    content.body = "\(text)"
    content.sound = UNNotificationSound.default
    
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: info.timeTask!)
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    let center = UNUserNotificationCenter.current()
    center.add(request, withCompletionHandler: nil)
}

func removeNotificationCenter(withIdentifier identifiers: [String]) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: identifiers)
}
