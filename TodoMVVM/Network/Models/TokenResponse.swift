//
//  TokenResponse.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/17/26.
//

import Foundation

struct TokenResponse: Codable {
    let refresh: String
    let access: String
}

