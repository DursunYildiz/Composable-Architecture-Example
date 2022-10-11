//
//  ContentView.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 10.10.2022.
//

import SwiftUI
import ComposableArchitecture
struct LoginView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

