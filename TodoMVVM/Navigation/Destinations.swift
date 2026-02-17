//
//  Destinations.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/17/26.
//

import SwiftUI

@ViewBuilder
func destinationView(for path: NavPath) -> some View {
    switch path {
    case .login:
        LoginView()
    case .register(let data):
        RegisterView(passedEmail: data)
    case .todoList:
        TodoListView()
    case .addTodo:
        AddTodoView()
    case .editTodo(_):
        AddTodoView()
    }
}
