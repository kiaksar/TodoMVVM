//
//  AuthUseCase.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/14/26.
//

import Foundation

enum AuthStatus {
    case success, failed
}

protocol AuthUseCaseProtocol {
    func validatePassword (password: String) -> Bool
    func login (email: String, password: String) async throws -> AuthMessage
    func register (email: String, password: String) async throws -> AuthMessage
}

struct AuthMessage {
    let message: String
    let status: AuthStatus
}

class AuthUseCaseImpl: AuthUseCaseProtocol {
    func validatePassword(password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$"#
        return password.range(of: passwordRegex, options: .regularExpression) != nil
    }
    
    func login (email: String, password: String) async throws -> AuthMessage {
        print("inside AuthUseCaseImpl.login")
        let res = try await AuthRemoteRepositoryImpl().login(email: email, password: password)
        if res is LoginResponse {
            return AuthMessage(message: "logged in successfully", status: .success)
        } else if let loginReject = res as? LoginReject {
            print("reject in AuthUseCaseImpl.login \(loginReject)")
            return AuthMessage(message: loginReject.detail, status: .failed)
        } else {
            return AuthMessage(message: "something went wrong", status: .failed)
        }
    }
    
    func register (email: String, password: String) async throws -> AuthMessage {
        let res = try await AuthRemoteRepositoryImpl().register(email: email, password: password)
        if res is RegisterResponse {
            return AuthMessage(message: "Registered Successfully", status: .success)
        } else if let registerReject = res as? RegisterReject {
            print("reject in AuthUseCaseImpl.register \(registerReject)")
            return AuthMessage(message: registerReject.email.first ?? "problem with email happened", status: .failed)
        } else {
            return AuthMessage(message: "something went wrong", status: .failed)
        }
    }
}

