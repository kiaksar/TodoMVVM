//
//  AuthResponse.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import Foundation

protocol LoginResponseProtocol: Codable {
    
}

struct LoginResponse: LoginResponseProtocol {
    let refresh: String
    let access: String
}

struct LoginReject: LoginResponseProtocol {
    let detail: String
}

