//
//  OAuthCredential.swift
//  Core
//
//  Created by Botond Magyarosi on 04/02/2021.
//  Based on https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#requestretrier
//

import Foundation
import Alamofire

struct OAuthCredential: Decodable, AuthenticationCredential {
    let accessToken: String
    let refreshToken: String
    let userId: String
    let expiration: Date

    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case userId = "user_id"
        case expiration
    }
}
