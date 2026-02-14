//
//  AuthResponse.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import Foundation
struct AuthResponse: Codable {
    let refresh: String
    let access: String
}

