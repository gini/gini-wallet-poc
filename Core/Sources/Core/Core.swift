//
//  Core.swift
//  
//
//  Created by Botond Magyarosi on 14/10/2020.
//

@_exported import DIKit
import RestBird

public extension DependencyContainer {

    static var networkClient = module {
        single { () -> NetworkClient in 
            let sessionManager = AlamofireSessionManager(config: APIConfiguration(), session: .default)
            return NetworkClient(session: sessionManager)
        }
    }
    
    static var apis = module {
        factory { AuthenticationAPI() }
        factory { NotificationAPI() }
    }
    
    static let repos = module {
        
    }

    static let states = module {
        single { AppState() }
    }
    
    static let useCases = module {
        factory { SignInUseCase() }
        factory { SignUpUseCase() }
        factory { SignOutUseCase() }
    }
}
