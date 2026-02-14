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
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = AuthServiceImpl()) {
        self.authService = authService
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
            // where should the AuthUseCase be used???
            print("doing the loggin with email \(email) and password \(password)")
            let _ = try await authService.login(email: email, password: password)
            isLoggedIn = true
            // navigate to login here or in the view???
        } catch {
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
        isLoading = true
        errorMessage = nil
        do {
            let _ = try await authService.register(email: email, password: password)
            isLoggedIn = true
            // navigate to login here or in the view???
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Registration failed. Please try again."
            isLoggedIn = false
        }
        isLoading = false
    }
    
    @MainActor
    func resetError() {
        errorMessage = nil
    }
}
