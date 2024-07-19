//
//  TodoListView.swift
//  CleanArchWeatherApp
//
//  Created by Ademola Kolawole on 19/07/2024.
//
import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoViewModel(repository: TodoRepositoryImpl(context: CoreDataStack.shared.context))
    @State private var newTodoTitle: String = ""
    
    var body: some View {
        VStack {
            TextField("New Todo", text: $newTodoTitle,onCommit: {
                if !newTodoTitle.isEmpty {
                    viewModel.addTodoItem(title: newTodoTitle, description: "", isCompleted: false)
                    newTodoTitle = ""
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            List {
                ForEach(viewModel.todos, id: \.id) { todo in
                    
                    HStack {
                        Text(todo.title.capitalized)
                            .strikethrough(todo.isCompleted, color: .red)
                            .foregroundColor(todo.isCompleted ? .gray : .black)
                        Spacer()
                        Button(action: {
                            viewModel.updateTodoItem(todo: Todo(id: todo.id, title: todo.title, description: todo.description, isCompleted: !todo.isCompleted))
                        }) {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                    }
                   
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        viewModel.deleteTodoItem(todo: viewModel.todos[index])
                    }
                    
                    
                }
            }
        }
    }
}

#Preview {
    TodoListView()
}
