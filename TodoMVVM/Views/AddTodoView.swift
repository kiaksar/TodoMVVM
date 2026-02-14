//
//  AddTodoView.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/8/26.
//

import SwiftUI
import Combine

struct AddTodoView: View {
    
    @StateObject var viewModel: TodoViewModel = .init()
    @State var title: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Todo Title", text: $title)
            }
            .navigationTitle("Add Todo Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        viewModel.addTodo(title: title)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTodoView()
}
