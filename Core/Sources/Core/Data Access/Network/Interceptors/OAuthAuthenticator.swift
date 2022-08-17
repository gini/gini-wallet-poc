//
//  OAuthAuthenticator.swift
//  Core
//
//  Created by Botond Magyarosi on 05/02/2021.
//

import Foundation
import Alamofire

extension Notification.Name {
    static let sessionExpired = Notification.Name("sessionExpired")
}

class OAuthAuthenticator: Authenticator {

    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }

    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        // Refresh the credential using the refresh token...then call completion with the new credential.
        //
        // The new credential will automatically be stored within the `AuthenticationInterceptor`. Future requests will
        // be authenticated using the `apply(_:to:)` method using the new credential.
    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `false`
        return false

        // If authentication server CAN invalidate credentials, then inspect the response matching against what the
        // authentication server returns as an authentication failure. This is generally a 401 along with a custom
        // header value.
        // return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `true`
        return true

        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
        // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        // return urlRequest.headers["Authorization"] == bearerToken
    }
}

//final class OAuthHandler: RequestInterceptor {
//
//    private let lock = NSLock()
//    private var isRefreshing = false
//
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        guard let tokenType = LocalStorage.tokenType, let accessToken = LocalStorage.accessToken else {
//            completion(.success(urlRequest))
//            return
//        }
//        var newRequest = urlRequest
//        newRequest.setValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")
//        completion(.success(newRequest))
//    }
//
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        lock.lock() ; defer { lock.unlock() }
//
//        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
//            guard let refreshToken = LocalStorage.refreshToken else {
//                completion(.doNotRetry)
//                NotificationCenter.default.post(name: .sessionExpired, object: nil)
//                return
//            }
////            requestsToRetry.append(completion)
//
//            if !isRefreshing {
//                refreshTokens(with: refreshToken) { result in
//                    self.lock.lock() ; defer { self.lock.unlock() }
//
//                    switch result {
//                    case .success(let authrorization):
//                        LocalStorage.tokenType = authrorization.tokenType
//                        LocalStorage.accessToken = authrorization.accessToken
//                        LocalStorage.refreshToken = authrorization.refreshToken
//                        completion(.retry)
//                    case .failure(let error):
//                        completion(.doNotRetryWithError(error))
//                    }
//                }
//            }
//        } else {
//            completion(.doNotRetry)
//        }
//    }
//
//    private func refreshTokens(with refreshToken: String, completion: @escaping (Result<AuthorizationDto, Error>) -> Void) {
//        let reqeust = URLRequest(url: URL(string: )!, method: .post)
//
//        guard !isRefreshing else { return }
//
//        isRefreshing = true
//
//        let parameters: [String: Any] = [
//            "refresh_token": refreshToken,
//            "grant_type": "refresh_token"
//        ]
//
//        Session.default.request("\(API.backendURL)/oauth/token?client_id=\(API.clientId)",
//                                method: .post,
//                                parameters: parameters)
//            .responseData { response in
//                if let data = response.data {
//                    do {
//                        let authorization = try JSONDecoder().decode(AuthorizationDto.self, from: data)
//                        completion(.success(authorization))
//                    } catch {
//                        completion(.failure(error))
//                    }
//                } else {
//                    completion(false, nil)
//                }
//                self.isRefreshing = false
//            }
//    }
//}
