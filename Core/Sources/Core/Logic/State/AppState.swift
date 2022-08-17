//
//  AppState.swift
//  skeleton
//
//  Created by Botond Magyarosi on 29.10.2020.
//

import SwiftUI

public final class AppState: ObservableObject {
    @Published public var isLoggedIn: Bool = false
    @Published public var needsProfileSetup: Bool = false
    
    public init() { }
}
