//
//  TodoViewModel.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/8/26.
//

import Foundation
import Combine
import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var filter: FilterType = .all
    
    enum FilterType {
        case all, active, completed
    }
    
    var filteredTodos: [Todo] {
        switch filter {
        case .all: return todos
        case .active: return todos.filter { t in
            t.isCompleted == false
        }
        case .completed: return todos.filter { t in
            t.isCompleted == true
        }
        }
    }
    
    func addTodo(title: String) {
        // modifications on the titile of the todo item can happen here
        todos.append(Todo(title: title))
    }
    
    func toggleCompletion(for id: UUID) {
        if let index = todos.firstIndex(where: { todo in
            todo.id == id
        })
        {
            todos[index].isCompleted.toggle()
        }
    }
    
    func deleteTodo(withId id: UUID) {
        todos.removeAll { todo in
            todo.id == id
        }
    }
    
    func loadSampleDate() { // put this in a network layer later
        todos = [
            Todo(title: "Buy groceries", isCompleted: false),
            Todo(title: "Finish SwiftUI MVVM lesson", isCompleted: true),
            Todo(title: "Workout", isCompleted: false)
        ]
    }
    
}
