//
//  LoginView.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var navigateToRegister: Bool = false
    var body: some View {
        NavigationStack {
            Form {
                // Make the checklist image big and centered
                Image(systemName: "checklist")
                    .font(.system(size: 80, weight: .regular)) // bigger symbol
                    .frame(maxWidth: .infinity, alignment: .center) // center horizontally
                    .padding(.vertical, 16)
                
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
                HStack {
                    Button {
                        navigateToRegister = true
                    } label: {
                        Text("Don't have an account? Sign Up")
                    }
                    Spacer()
                    Button {
                        print("Button")
                    } label: {
                        Text("Login")
                    }
                    .buttonStyle(.bordered)
                }
                
            }
            .navigationTitle("Login to Todo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $navigateToRegister) {
                RegisterView(username: username)
            }
        }
        
    }
}

#Preview {
    LoginView()
}
