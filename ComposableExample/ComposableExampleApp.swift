//
//  ComposableExampleApp.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 10.10.2022.
//

import ComposableArchitecture
import SwiftUI
@main
struct ComposableExampleApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(store: Store(
                initialState: LoginDomain.State(),
                reducer: LoginDomain.reducer,
                environment: LoginDomain.Environment(mainQueue: .main,
                                                     service: AuthServiceImplement())))
        }
    }
}
