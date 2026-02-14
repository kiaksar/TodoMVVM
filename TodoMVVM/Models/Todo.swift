//
//  Todo.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/8/26.
//

import Foundation

struct Todo: Codable, Identifiable { // Identifiable is required for foreach (a field named id is required)
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.id = UUID()
        self.title = title
        self.isCompleted = isCompleted
    }
}

