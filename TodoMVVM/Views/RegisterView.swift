//
//  RegisterView.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/9/26.
//

import SwiftUI

struct RegisterView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var navigateToLogin: Bool = false
    var body: some View {
        NavigationStack {
            Form {
                Image(systemName: "checklist")
                    .font(.system(size: 80, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 16)

                TextField("Username", text: $username)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
                HStack {
                    Button {
                        navigateToLogin = true
                    } label: {
                        Text("Already have an account? Login")
                    }
                    Spacer()
                    Button {
                        print("Button")
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(.bordered)
                }

            }
            .navigationTitle("Create a Todo account")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView(username: username)
            }
        }
        
    }
}

#Preview {
    RegisterView()
}
