//
//  Tests.swift
//  Tests
//
//  Created by Botond Magyarosi on 24/11/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import skeleton

class Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_app_starts_with_login() throws {
        let view = RootPage()
            .environmentObject(AppState())
    }
}
