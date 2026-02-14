//
//  AuthUseCase.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/14/26.
//

import Foundation

protocol AuthUseCaseProtocol {
    func validatePassword (password: String) -> Bool
}

class AuthUseCaseImpl: AuthUseCaseProtocol {
    func validatePassword(password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$"#
        return password.range(of: passwordRegex, options: .regularExpression) != nil
    }
}

