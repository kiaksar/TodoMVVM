//
//  AuthManager.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> AuthResponse
    func register(email: String, password: String) async throws -> AuthResponse
}

class AuthRepositoryImpl: AuthRepositoryProtocol {
    private let api: AuthAPI
    private let encoder: JSONEncoder

    init(api: AuthAPI = AuthAPI(), encoder: JSONEncoder = JSONEncoder()) {
        self.api = api
        self.encoder = encoder
    }

    func login(email: String, password: String) async throws -> AuthResponse {
        let body = try encoder.encode(User(email: email, password: password))
        let loginEndpoint = Endpoint(path: "/auth/login", method: .post, body: body)
        let response: AuthResponse = try await api.authRequest(loginEndpoint)
        return response
    }
    
    func register(email: String, password: String) async throws -> AuthResponse {
        let body = try encoder.encode(User(email: email, password: password))
        let registerEndpoint = Endpoint(path: "/auth/register", method: .post, body: body)
        let response: AuthResponse = try await api.authRequest(registerEndpoint)
        return response
    }
}
