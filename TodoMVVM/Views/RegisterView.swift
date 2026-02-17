//
//  RegisterView.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import SwiftUI

struct RegisterView: View {
    @State var navigateToLogin: Bool = false
    @ObservedObject var viewModel: AuthViewModel = AuthViewModel() // is it ok to use the same viewModel for login and register???
    var body: some View {
        NavigationStack {
            Form {
                Image(systemName: "checklist")
                    .font(.system(size: 80, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 16)
                
                TextField("Username", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $viewModel.password)
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                HStack {
                    Button {
                        navigateToLogin = true
                    } label: {
                        Text("Already have an account? Login")
                    }
                    Spacer()
                    Button {
                        print("Button")
                        Task {
                            await viewModel.register()
                        }
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(.bordered)
                }
                
            }
            .alert(viewModel.errorMessage ?? "oops", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                Button {
                    viewModel.resetError()
                } label: {
                    Text("Ok")
                }
            })
            .navigationTitle("Create a Todo account")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView(viewModel: viewModel)
            }
            .disabled(viewModel.isLoading)
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                }
            }
        }
        
    }
}

#Preview {
    RegisterView()
}
