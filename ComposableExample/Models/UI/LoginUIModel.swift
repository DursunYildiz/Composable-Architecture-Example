//
//  LoginUIModel.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 13.10.2022.
//

import Foundation
struct LoginUIModel: Codable {
    let userName: String
    let password: String

    func validate () -> ValidateResult {
        var result = ValidateResult()
        if userName.count < 2 {
            result.userName = "uzunluk en az 3 olmalı"
            result.isSucces = false
        }
        if password.count < 8 {
            result.password = "uzunluk en az 8 olmalı"
        }
        return result
    }
    struct ValidateResult {
        var userName: String = ""
        var password: String = ""
        var isSucces: Bool = true
    }
}
