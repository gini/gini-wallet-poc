//
//  File.swift
//  
//
//  Created by Noemi Kalman on 18.09.2022.
//

import Alamofire
import Foundation

protocol Request {
    var method: HTTPMethod { get }
    var path: String? { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: Any] { get }
    var needsAuthorization: Bool { get }
    var dataDecoder: DataDecoder { get }
    var parameterEncoding: ParameterEncoding { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var body: String? { get }
}

extension Request {
    var method: HTTPMethod { .get }
    var path: String? { nil }
    var headers: HTTPHeaders? {
        HTTPHeaders([
            "content-type": "application/xml",
            "accept": "*/*",
            "Authorization": "Basic \(authorization)"
        ])
    }
    
    var authorization: String {
        let username = "payee_user"
        let password = "userPw"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        return base64LoginString
    }
    
    var parameters: [String: Any] { [:] }
    var needsAuthorization: Bool { false }
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .post, .put, .patch:
            return BodyStringEncoding(body: body ?? "")
        default:
            return URLEncoding.default
        }
    }
    var dataDecoder: DataDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.formatted(dateFormatter)
        return decoder
    }
    var cachePolicy: URLRequest.CachePolicy {
        .reloadIgnoringLocalCacheData
    }
}

