//
//  AppEngine.swift
//  skeleton
//
//  Created by Botond Magyarosi on 05/02/2021.
//

import Foundation
import DIKit
//import Firebase
#if canImport(Wormholy)
import Wormholy
#endif
import Core

struct AppEngine {

    func prepareAppStart() {
        DependencyContainer.defined(by: modules {
            DependencyContainer.networkClient
            DependencyContainer.apis
            DependencyContainer.repos
            DependencyContainer.states
            DependencyContainer.useCases
        })

        #if canImport(Wormholy)
        Wormholy.ignoredHosts = ["app-measurement.com"]
        #endif
    }
}
