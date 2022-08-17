//
//  ForceUpdateInterceptor.swift
//  Core
//
//  Created by Botond Magyarosi on 05/02/2021.
//

import Foundation
import Alamofire

public extension Notification.Name {
    static let forceUpdateNeeded = Notification.Name("forceUpdateNeeded")
}

/*
 This is a common implementation with backend team.

 To learn more about it check out:
 https://www.notion.so/halcyonmobile/Force-update-in-project-skeletons-1e1d660d5e434eb3af9ecc5256518270
 */
struct ForceUpdateInterceptor: RequestRetrier {

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if case APIError.forceUpdateNeeded = error {
            NotificationCenter.default.post(name: .forceUpdateNeeded, object: nil)
        }
        completion(.doNotRetry)
    }
}
