//
//  TodoListView.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/8/26.
//

import SwiftUI

struct TodoListView: View {
    
    @StateObject private var viewModel: TodoViewModel = .init()
    @State var showAddTodo: Bool = false
    @EnvironmentObject private var router: Router
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.filteredTodos) { todo in
                    Button {
                        viewModel.toggleCompletion(for: todo.id)
                    } label: {
                        Text(todo.title)
                            .strikethrough(todo.isCompleted)
                    }
                    .swipeActions {
                        Button {
                            viewModel.deleteTodo(withId: todo.id)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddTodo = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.loadSampleDate()
        }
        .sheet(isPresented: $showAddTodo) {
            AddTodoView(viewModel: viewModel)
        }
    }
}

#Preview {
    TodoListView()
}
