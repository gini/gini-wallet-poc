//
//  LocalStorage.swift
//  Core
//
//  Created by Botond Magyarosi on 14/10/2020.
//

import Foundation

final class LocalStorage {
    @UserDefault("accessToken", defaultValue: nil)
    static var accessToken: String?
    
    @UserDefault("refreshToken", defaultValue: nil)
    static var refreshToken: String?
    
    // MARK: - Device token
    
    @UserDefault("deviceToken", defaultValue: nil)
    static var deviceToken: String?
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}
