//
//  NavPath.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/17/26.
//

import Foundation

enum NavPath: Hashable {
    case login
    case register(String? = nil)
    case todoList
    case addTodo
    case editTodo(UUID)
}
