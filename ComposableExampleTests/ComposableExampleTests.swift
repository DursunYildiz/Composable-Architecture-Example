//
//  ComposableExampleTests.swift
//  ComposableExampleTests
//
//  Created by Dursun YILDIZ on 10.10.2022.
//

import ComposableArchitecture
import XCTest
final class ComposableExampleTests: XCTestCase {
    let mainQuee = DispatchQueue.test
    let store = TestStore(initialState: LoginDomain.State(),
                          reducer: LoginDomain.reducer,
                          environment: LoginDomain.Environment(mainQueue: DispatchQueue.test.eraseToAnyScheduler(),
                                                               service: AuthServiceMock()))
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

    func testUserName() throws {
        store.send(.changeUserName("Username")) {
            $0.userName = "Username"
        }
    }

    func testServiceSuccesfull() async throws {
        do {
            let model = try await store.environment.service.login(with: .init(userName: "test", password: "testtetete"))
            XCTAssertTrue(model.isSucces ?? false)
            _ = await store.send(.loginResponse(model)) {
                $0.isSucces = true
            }
        } catch let error as NetworkError {
            XCTAssertEqual("", error.description)
        } catch {}
    }

    func testServiceFail() async throws {
        do {
            let model = try await store.environment.service.login(with: .init(userName: "", password: ""))
            XCTAssertFalse(model.isSucces ?? true)

        } catch let error as NetworkError {
            XCTAssertEqual("test123", error.description)
        } catch {
            XCTAssertTrue(true)
        }
    }
}
