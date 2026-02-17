//
//  TokenRepository.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/17/26.
//

import Foundation
import KeychainAccess

protocol TokenRepositoryProtocol {
    func saveTokens(accessToken: String, refreshToken: String) throws
    func getAccessToken() -> String?
    func getRefreshToken() -> String?
    func clearTokens() throws
}

class TokenRepositoryImpl: TokenRepositoryProtocol {
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "com.mtdev.todomvvm")
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refereshToken"
    
    func saveTokens(accessToken: String, refreshToken: String) throws {
        try keychain.set(accessToken, key: accessTokenKey)
        try keychain.set(refreshToken, key: refreshTokenKey)
    }
    
    func getAccessToken() -> String? {
        return try? keychain.get(accessTokenKey)
    }
    
    func getRefreshToken() -> String? {
        return try? keychain.get(refreshTokenKey)
    }
    
    func clearTokens() throws {
        try keychain.remove(accessTokenKey)
        try keychain.remove(refreshTokenKey)
    }
    
    
}
