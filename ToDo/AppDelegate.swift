//
//  AppDelegate.swift
//  ToDo
//
//  Created by Albert on 09.05.2020.
//  Copyright © 2020 Albert Mykola. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func applicationDidEnterBackground(_ application: UIApplication) {
            Created.shared.save(forKey: "arrayInfo", value: AllTask.shared.notPerformed)
        Created.shared.save(forKey: "tasksCompleted", value: AllTask.shared.tasksCompleted)
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
        }
        return true
    }
}

