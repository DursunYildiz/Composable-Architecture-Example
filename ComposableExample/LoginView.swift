//
//  ContentView.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 10.10.2022.
//

import ComposableArchitecture
import SwiftUI
struct LoginView: View {
    let store: Store<LoginViewAppState, LoginViewAction>

    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                VStack(spacing: 24) {
                    TextField("User Name", text: viewStore.binding(\.$userName))
                        .modifier(BackgroundModifier(color: .purple.opacity(0.2)))
                    TextField(
                        "Password",
                        text: viewStore.binding(get: \.password, send: LoginViewAction.changePassword)
                    )
                    .modifier(BackgroundModifier(color: .blue.opacity(0.5)))
                    Button {
                        viewStore.send(.login, animation: .default)

                    } label: {
                        Text("Login")
                    }
                    .frame(maxWidth: .infinity)
                    .modifier(BackgroundModifier(color: .orange))
                }
                .padding()
                .blur(radius: viewStore.isLoading ? 1 : 0)
                .overlay {
                    ZStack {
                        if viewStore.isLoading {
                            ProgressView()
                        }
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(initialState: LoginViewAppState(),
                               reducer: loginViewReducer, environment: LoginViewEnvironment(mainQueue: .main)))
    }
}

struct LoginViewAppState: Equatable {
    @BindableState var userName: String = ""
    var password: String = ""
    var isLoading: Bool = false
    
}

enum LoginViewAction: BindableAction {
    case binding(BindingAction<LoginViewAppState>)
    case login
    case changePassword(String)
    case changeLoading(Bool)
}

struct LoginViewEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let loginViewReducer = Reducer<LoginViewAppState, LoginViewAction, LoginViewEnvironment> { state, action, _ in

    switch action {
    case .login:
        return .none
    case .binding:
        return .none
    case let .changePassword(text):
        state.password = text
        return .none

    case let .changeLoading(status):
        state.isLoading = status

        return .none
    }

}.binding()

struct BackgroundModifier: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color)
            }
    }
}
