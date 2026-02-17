//
//  PasswordValidationUseCase.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/17/26.
//

import Foundation

protocol PasswordValidationUseCaseProtocol {
    func validate(password: String) -> Bool
}

class PasswordValidationUseCaseImpl: PasswordValidationUseCaseProtocol {
    func validate(password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$"#
        return password.range(of: passwordRegex, options: .regularExpression) != nil
    }
}

