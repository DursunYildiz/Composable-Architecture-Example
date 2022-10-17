//
//  LoginResponseModel.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 13.10.2022.
//

import Foundation
struct LoginResponseModel: Codable {
    let isSucces: Bool?

    init(isSucces: Bool? = false) {
        self.isSucces = isSucces
    }
}
