//
//  LoginView.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import SwiftUI

struct LoginView: View {
    @State var navigateToRegister: Bool = false
    @ObservedObject var viewModel: AuthViewModel = AuthViewModel()
    var body: some View {
        NavigationStack {
            Form {
                // Make the checklist image big and centered
                Image(systemName: "checklist")
                    .font(.system(size: 80, weight: .regular)) // bigger symbol
                    .frame(maxWidth: .infinity, alignment: .center) // center horizontally
                    .padding(.vertical, 16)
                
                TextField("Username", text: $viewModel.email).textInputAutocapitalization(.never).autocorrectionDisabled(true).keyboardType(.emailAddress)
                SecureField("Password", text: $viewModel.password)
                HStack {
                    Button {
                        navigateToRegister = true
                    } label: {
                        Text("Don't have an account? Sign Up")
                    }
                    Spacer()
                    Button {
                        print("Button")
                        Task {
                            await viewModel.login()
                        }
                    } label: {
                        Text("Login")
                    }
                    .buttonStyle(.bordered)
                }
                
            }
            .navigationTitle("Login to Todo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $navigateToRegister) {
                RegisterView(viewModel: viewModel) // is it true to pass viewModels like this???
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                TodoListView()
                // is this a good place to handle navigation if user is logged in???
            }
        }
        
    }
}

#Preview {
    LoginView()
}
