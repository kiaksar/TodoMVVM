//
//  AuthViewModel.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/14/26.
//

import Foundation
import Combine

protocol AuthViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var confirmPassword: String {get set}
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var isLoggedIn: Bool { get set }
    
    func login() async
    func register() async
    func resetError()
}

class AuthViewModel: AuthViewModelProtocol {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    
    private let authUseCase: AuthUseCaseProtocol
    
    init(authUseCase: AuthUseCaseProtocol = AuthUseCaseImpl()) {
        self.authUseCase = authUseCase
    }
    
    @MainActor
    func login() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required."
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            print("doing the login with email \(email) and password \(password)")
            let res = try await authUseCase.login(email: email, password: password)
            if res.status == .success {
                isLoggedIn = true
            } else {
                errorMessage = res.message
            }
        } catch {
            print("error in catch of the login viewModel \(error)")
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Login failed. Please try again."
            isLoggedIn = false
        }
        isLoading = false
    }
    
    @MainActor
    func register() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required."
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Password and confirm password do not match."
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let res = try await authUseCase.register(email: email, password: password)
            if res.status == .success {
                isLoggedIn = true
            } else {
                errorMessage = res.message
            }
        } catch {
            print("error in catch of the register viewModel \(error)")
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Registration failed. Plsease try again."
            isLoggedIn = false
        }
        isLoading = false
    }
    
    @MainActor
    func resetError() {
        errorMessage = nil
    }
}
