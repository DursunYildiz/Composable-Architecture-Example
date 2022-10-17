//
//  MainView.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 10.10.2022.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: Store<LoginDomain.State, LoginDomain.Action>
    var body: some View {
        WithViewStore(store) { viewStore in
            Text(viewStore.userName)
        }

    }
}
