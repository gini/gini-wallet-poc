//
//  NotificationAPI.swift
//  
//
//  Created by Botond Magyarosi on 03.11.2020.
//

import Foundation
import Combine
import RestBird

final class NotificationAPI {
    @LazyInject private var networkClient: NetworkClient
    
    func register(token: String) -> Future<Void, Error> {
        struct Request: DataRequest {
            typealias ResponseType = EmptyResponse
            typealias RequestType = UpdateNotificationTokenDto
            
            var parameters: UpdateNotificationTokenDto?
        }
        return networkClient.combine.execute(request: Request(parameters: UpdateNotificationTokenDto(token: token)))
    }
    
    func unregister(token: String) -> Future<Void, Error> {
        struct Request: DataRequest {
            typealias ResponseType = EmptyResponse
            typealias RequestType = UpdateNotificationTokenDto
            
            var parameters: UpdateNotificationTokenDto?
        }
        return networkClient.combine.execute(request: Request(parameters: UpdateNotificationTokenDto(token: token)))
    }
}
