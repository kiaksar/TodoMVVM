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
    var tokenRepository: TokenRepositoryProtocol { get }
    func login (email: String, password: String) async throws -> AuthMessage
    func register (email: String, password: String) async throws -> AuthMessage
}

struct AuthMessage {
    let message: String
    let status: AuthStatus
}

class AuthUseCaseImpl: AuthUseCaseProtocol {
    
    internal let tokenRepository: TokenRepositoryProtocol
    
    init(tokenRepository: TokenRepositoryProtocol = TokenRepositoryImpl()) {
        self.tokenRepository = tokenRepository
    }
    
    func login (email: String, password: String) async throws -> AuthMessage {
        print("inside AuthUseCaseImpl.login")
        let res = try await AuthRemoteRepositoryImpl().login(email: email, password: password)
        if let loginResponse = res as? LoginResponse {
            try tokenRepository.saveTokens(accessToken: loginResponse.access, refreshToken: loginResponse.refresh)
            return AuthMessage(message: "logged in successfully", status: .success)
        } else if let loginReject = res as? LoginReject {
            print("reject in AuthUseCaseImpl.login \(loginReject)")
            return AuthMessage(message: loginReject.detail, status: .failed)
        } else {
            return AuthMessage(message: "something went wrong", status: .failed)
        }
    }
    
    func register (email: String, password: String) async throws -> AuthMessage {
        guard PasswordValidationUseCaseImpl().validate(password: password) else {
            return AuthMessage(message: "Please use a strong password", status: .failed)
        }
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
