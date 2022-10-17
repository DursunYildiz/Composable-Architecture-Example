//
//  AuthService.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 13.10.2022.
//

import Foundation

protocol AuthService {
    func login(with: LoginUIModel) async throws -> LoginResponseModel
}
class AuthServiceImplement: AuthService {
    func login(with: LoginUIModel) async throws -> LoginResponseModel {
        let validateResult = with.validate()
         if  validateResult.isSucces {

             return .init(isSucces: true)
         }
         throw NetworkError.badRequest
    }

}
class AuthServiceMock: AuthService {
    func login(with: LoginUIModel) async throws -> LoginResponseModel {
        let model: LoginResponseModel? = MockReader.loadObject(name: "Login")

       let validateResult = with.validate()
        if let model, validateResult.isSucces {

            return model
        }
        throw NetworkError.badRequest
    }

}
enum NetworkError: Error {
    case badRequest

}
extension NetworkError {
    var description: String {
        switch self {
        case .badRequest :
           return "test123"
        }
    }
}
