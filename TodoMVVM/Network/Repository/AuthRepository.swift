//
//  AuthManager.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import Foundation
import PapyrusAlamofire

protocol AuthRemoteRepositoryProtocol {
    func login(email: String, password: String) async throws -> LoginResponseProtocol
    func register(email: String, password: String) async throws -> RegisterResponseProtocol
}

class AuthRemoteRepositoryImpl: AuthRemoteRepositoryProtocol {
    
    func login(email: String, password: String) async throws -> LoginResponseProtocol {
        print("inside AuthRemoteRepositoryImpl.login")
        let response = try await authAPI.login(email: email, password: password)
        print("response from the AuthRemoteRepositoryImpl.login \(response)")
        
        if (response.statusCode == 200) {
            let loginResponse: LoginResponse = try response.decode(LoginResponse.self, using: JSONDecoder())
            return loginResponse
        } else {
            let loginReject: LoginReject = try response.decode(LoginReject.self, using: JSONDecoder())
            return loginReject
        }
    }
    
    func register(email: String, password: String) async throws -> RegisterResponseProtocol {
        print("inside AuthRemoteRepositoryImp.register")
        let response = try await authAPI.register(email: email, password: password)
        print("response from the authAPI.register \(response)")
        
        if (response.statusCode == 201) {
            let registerResponse: RegisterResponse = try response.decode(RegisterResponse.self, using: JSONDecoder())
            return registerResponse
        } else {
            let registerReject: RegisterReject = try response.decode(RegisterReject.self, using: JSONDecoder())
            return registerReject
        }
    }
}
