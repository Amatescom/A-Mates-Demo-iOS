//
//  AppDelegate.swift
//  A-Mates-Demo
//
//  Created by Mikalai Kuts on 05/10/2023.
//

import UIKit
import AMatesiOS

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let config = AMatesConfig(
            appConfig: AMatesAppConfig(appId: "YOUR_COMMUNITY_APP_ID_HERE", language: .currentLocale),
            interfaceConfig: AMatesUIInterfaceConfig(interfaceStyle: .unspecified) // Optional
        )
        AMates.setup(with: config)
        
        return true
    }
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenParts = deviceToken.map
        { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print(token)
        AMates.updatePushConfigs(with: token)
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        AMates.didReceive(response: response)
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions
        ) -> Void) {
        if AMates.checkPush(notification: notification) {
            if AMates.showPush(notification: notification) {
                completionHandler([.badge, .sound])
            } else {
                completionHandler([])
            }
        } else {
            // Сustomer settings
        }
    }
}

