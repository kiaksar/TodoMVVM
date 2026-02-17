//
//  RegisterResponse.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/17/26.
//

import Foundation

protocol RegisterResponseProtocol: Codable {
    
}

struct RegisterResponse: RegisterResponseProtocol {
    let user: UserResponse
    let tokens: TokenResponse
}

struct RegisterReject: RegisterResponseProtocol {
    let email: [String]
}
