//
//  LoginDomain.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 13.10.2022.
//

import ComposableArchitecture
import Foundation
struct LoginDomain {
    struct State: Equatable {
        static func == (lhs: LoginDomain.State, rhs: LoginDomain.State) -> Bool {
            return true
        }

        var userName: String = ""
        var password: String = ""
        var isLoading: Bool = false
        var isSucces: Bool = false
        var message: String = ""
        var alertState: AlertState<Action>?
    }

    enum Action {
        case login
        case changePassword(String)
        case changeUserName(String)
        case changeLoading(Bool)
        case loginResponse(LoginResponseModel)
        case loginError(Error)
    }

    struct Environment {
        var mainQueue: AnySchedulerOf<DispatchQueue> = .main
        var service: AuthService
    }

    static let reducer = Reducer<State, Action, Environment> { state, action, enviroment in

        switch action {
        case .login:
            state.isLoading = true
            let model: LoginUIModel = .init(userName: state.userName,
                                            password: state.password)

            return .run { send in
                do {
                    try await send.send(Action.loginResponse(enviroment.service.login(with: model)))

                } catch {
                    await send.send(Action.loginError(error))
                }
            }
        case let .changePassword(text):
            state.password = text
            return .none

        case let .changeLoading(status):
            state.isLoading = status

            return .none

        case let .changeUserName(text):
            state.userName = text
            return .none
        case let .loginResponse(model):

            state.isSucces = model.isSucces ?? false
            print(model)

            state.isLoading = false
            return .none

        case let .loginError(error):
            state.isLoading = false

            if let error = error as? NetworkError {
                state.alertState = AlertState(title: TextState(verbatim: error.description))
            } else {
                print(error.localizedDescription)
            }
            return .none
        }
    }
}
