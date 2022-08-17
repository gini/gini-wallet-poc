//
//  APIConfiguration.swift
//  
//
//  Created by Botond Magyarosi on 14/10/2020.
//

import Foundation
import RestBird

struct APIConfiguration: NetworkClientConfiguration {
    let baseUrl: String = "https://api.test.com"
    let jsonEncoder: JSONEncoder = .init()
    let jsonDecoder: JSONDecoder = .init()

    init() { }
}
