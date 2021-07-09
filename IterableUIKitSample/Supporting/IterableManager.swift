//
//  IterableManager.swift
//  IterableSample
//
//  Created by Christina Schell on 5/11/21.
//

import SwiftUI
import UserNotifications
import IterableSDK
import Combine

class IterableManager {

    static let shared = IterableManager()
    let config = IterableConfig()
    let inAppDelegate = CustomInAppUrlDelegate()

    private init() { }

    func start(with launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        config.urlDelegate = inAppDelegate
        IterableAPI.initialize(apiKey: Tokens.apiKey,
                               launchOptions: launchOptions,
                               config: config)
        IterableAPI.email = Tokens.email
    }
    
    class func updateUser(with fields: [String: Any]) {
        IterableAPI.updateUser(fields, mergeNestedObjects: true)
    }
    
    class func track(custom event: String, data: [String: Any]? = nil) {
        IterableAPI.track(event: event, dataFields: data)
    }
    
    // TODO: update cart
    
    class func track(purchase: NSNumber, items: CommerceItems, data: [String: Any]? = nil) {
        guard let items = items as? [CommerceItem] else {
            return
        }
        IterableAPI.track(purchase: purchase, items: items, dataFields: data)
    }

}

extension IterableManager {
    
    class func register(token: Data) {
        IterableAPI.register(token: token)
    }
    
    class func didReceiveRemoteNotification(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        IterableAppIntegration.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    class func didReceiveUniversalLink(with url: URL) {
        IterableAPI.handle(universalLink: url)
    }
    
    class func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        IterableAppIntegration.userNotificationCenter(center, didReceive: response, withCompletionHandler: completionHandler)
    }
}

// https://support.iterable.com/hc/en-us/articles/360035536791-In-App-Messages-on-iOS-
// TODO: Set up custom URL and Action delegates
class CustomIterableAppDelegate: IterableInAppDelegate {
    
    // Overriding default behavior for certain messages
    func onNew(message: IterableInAppMessage) -> InAppShowResponse {
        if message.messageId == "messgageToSkip" {
            return .skip
        }
        return .show
    }
}

class CustomInAppAction: IterableCustomActionDelegate {
    func handle(iterableCustomAction action: IterableAction, inContext context: IterableActionContext) -> Bool {
        return true
    }
}

class CustomInAppUrlDelegate: IterableURLDelegate {
    func handle(iterableURL url: URL, inContext context: IterableActionContext) -> Bool {
        DonutManager.handle(url)
    }
}
