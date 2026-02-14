//
//  AuthService.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/14/26.
//

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> AuthResponse
    func register(email: String, password: String) async throws -> AuthResponse
}

class AuthServiceImpl: AuthServiceProtocol {
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol = AuthRepositoryImpl()) {
        self.authRepository = authRepository
    }
    
    // call repository to access the stored token in the database here??
    
    func login(email: String, password: String) async throws -> AuthResponse {
        try await authRepository.login(email: email, password: password)
        // store the token temporarly here or in the repository????
    }
    
    func register(email: String, password: String) async throws -> AuthResponse {
        try await authRepository.register(email: email, password: password)
    }
    
}

