//
//  ComposableExampleTests.swift
//  ComposableExampleTests
//
//  Created by Dursun YILDIZ on 10.10.2022.
//

import XCTest
import ComposableArchitecture
final class ComposableExampleTests: XCTestCase {
    let store = TestStore(initialState: LoginViewAppState(),
                          reducer: loginViewReducer,
                          environment: LoginViewEnvironment(mainQueue: .main))
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testPasswordChange() throws {
        store.send(.changePassword("Test")) {
            $0.password = "Test"
        }
    }
    func testLoadingChange() throws {
        store.send(.changeLoading(true)) {
            $0.isLoading = true
        }
        store.send(.changeLoading(false)) {
            $0.isLoading = false
        }
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
