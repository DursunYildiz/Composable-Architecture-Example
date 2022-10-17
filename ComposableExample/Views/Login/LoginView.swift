//
//  ContentView.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 10.10.2022.
//

import ComposableArchitecture
import SwiftUI
struct LoginView: View {
    let store: Store<LoginDomain.State, LoginDomain.Action>
    let action = LoginDomain.Action.self
    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                VStack(spacing: 24) {
                    TextField("User Name",
                              text: viewStore.binding(get: \.userName, send: action.changeUserName))
                        .modifier(BackgroundModifier(color: .purple.opacity(0.2)))
                    TextField(
                        "Password",
                        text: viewStore.binding(get: \.password, send: action.changePassword)
                    )
                    .modifier(BackgroundModifier(color: .blue.opacity(0.5)))
                    Button {
                        viewStore.send(.login, animation: .default)

                    } label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .modifier(BackgroundModifier(color: .orange))
                    }

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
        LoginView(store: Store(initialState: LoginDomain.State(),
                               reducer: LoginDomain.reducer,
                               environment: LoginDomain.Environment(mainQueue: .main, service: AuthServiceMock())))
    }
}

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
