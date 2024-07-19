//
//  TodoViewModel.swift
//  CleanArchWeatherApp
//
//  Created by Ademola Kolawole on 19/07/2024.
//

import Foundation
import Combine


class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    private let repository: TodoRepository
    private var cancellables = Set<AnyCancellable>()
    
    
    init(repository: TodoRepository) {
        self.repository = repository
        getAllTodos()
    }
    
    
    func getAllTodos() {
        repository.getAllTodos()
            .sink { _ in
            
            } receiveValue: { [weak self] todos in
                self?.todos = todos
            }
            .store(in: &cancellables)

    }
    
    func addTodoItem(title: String, description: String, isCompleted: Bool) {
        let todo = Todo(title: title, description: description, isCompleted: isCompleted)
        repository.addTodo(todo)
            .sink { _ in
                
            } receiveValue: { [weak self] in
                self?.getAllTodos()
            }
            .store(in: &cancellables)
    }
    
    func updateTodoItem(todo: Todo) {
        repository.updateTodo(todo)
            .sink { _ in
                
            } receiveValue: { [weak self] in
                self?.getAllTodos()
            }
            .store(in: &cancellables)
    }
    
    func deleteTodoItem(todo: Todo) {
        repository.deleteTodo(todo)
            .sink { _ in
                
            } receiveValue: { [weak self] in
                self?.getAllTodos()
            }
            .store(in: &cancellables)
    }
}
