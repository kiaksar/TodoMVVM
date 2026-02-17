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
    @EnvironmentObject private var router: Router
    
    var body: some View {
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
            HStack {
                Button {
                    router.push(.register(viewModel.email))
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
        .alert(viewModel.errorMessage ?? "oops", isPresented: .constant(viewModel.errorMessage != nil), actions: {
            Button {
                viewModel.resetError()
            } label: {
                Text("OK")
            }
        })
        .navigationTitle("Login to Todo")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationDestination(isPresented: $navigateToRegister) {
//            RegisterView(viewModel: viewModel)
//        }
//        .navigationDestination(isPresented: $viewModel.isLoggedIn) {
//            TodoListView()
//        }
        .disabled(viewModel.isLoading)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
            }
        }
        .onChange(of: viewModel.isLoggedIn) { oldValue, newValue in
            if newValue {
                router.navigateToRootAndPush(.todoList)
            }
        }
        
        
    }
}

#Preview {
    LoginView()
}
