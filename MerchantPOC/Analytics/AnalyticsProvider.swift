//
//  AnalyticsProvider.swift
//  skeleton
//
//  Created by Botond Magyarosi on 10/02/2021.
//

import Foundation

protocol AnalyticsProvider {
    func initialize()
    func track(event: AnalyticsEvent)
    func setUserInfo(id: String, email: String, name: String)
    func reset()
}

// import Firebase

//class FirebaseAnalyticsProvider: AnalyticsProvider {
//
//    private let token = ""
//
//    // A mapper to map the even names and parameters according to Firebase standards
//    private let eventMapper = FirebaseAnalyticsEventMapper()
//
//    public init() {}
//
//    public func initialize() {}
//
//    public func track(event: AnalyticsEvent) {
//        let eventName = eventMapper.eventName(for: event)
//        let eventParams: [String: NSObject] = eventMapper.eventParameters(for: event)
//        Analytics.logEvent(eventName, parameters: eventParams)
//    }
//
//    // 'Set' the events that this provider is 'subscribed' to
//    public func shouldTrack(event: AnalyticsEvent) -> Bool {
//        // It returns directly true, until we have another provider that should track other events than Firebase
//        return true
//    }
//
//    // 'Set' the user properties
//    public func setUserInfo(id: String, email: String, name: String) {
//        Analytics.setUserID(id)
//        Analytics.setUserProperty(email, forName: FirebaseAnalyticsEventMapper.UserProperty.email)
//        Analytics.setUserProperty(name, forName: FirebaseAnalyticsEventMapper.UserProperty.name)
//    }
//
//    public func reset() {
//        Analytics.setUserID(nil)
//    }
//}
