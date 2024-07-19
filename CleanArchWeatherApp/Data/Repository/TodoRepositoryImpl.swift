//
//  EventRepositoryImpl.swift
//  CleanArchWeatherApp
//
//  Created by Ademola Kolawole on 19/07/2024.
//

import Foundation
import Combine
import CoreData

struct TodoRepositoryImpl: TodoRepository{
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addTodo(_ item: Todo) -> AnyPublisher<Void, Error> {
        let todoItem = TodoItem(context: context)
        todoItem.title = item.title
        todoItem.desc = item.description
        todoItem.isCompleted = item.isCompleted
        todoItem.id = item.id
    
        return Future<Void, Error> { promise in
            do {
                try self.context.save()
                promise(.success(()))
            } catch  {
                promise(.failure(error))
            }
            
        }
        .eraseToAnyPublisher()
    }

    func getAllTodos() -> AnyPublisher<[Todo], Error> {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        return Future<[Todo], Error> { promise in
            do {
                let results = try self.context.fetch(request)
                let todos = results.map({ Todo(id: $0.id!, title: $0.title!, description: $0.desc!, isCompleted: $0.isCompleted) })
                promise(.success(todos))
            } catch {
                print("Error fetching todos: \(error)")
                promise(.failure(error))
            }
            
        }
        .eraseToAnyPublisher()
    }
    
   
    
    func updateTodo(_ item: Todo) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
           
                let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
                
            do {
                if let results = try self.context.fetch(request).first {
                    results.title = item.title
                    results.desc = item.description
                    results.isCompleted = item.isCompleted
                   
                    try self.context.save()
                    promise(.success(()))
                } else {
                    
                    promise(.failure(NSError(domain: "Todo not found", code: 404, userInfo: nil)))
                }
            }catch {
                print("Error updating todos: \(error)")
                    promise(.failure(error))
                }
        }
        .eraseToAnyPublisher()
        
    }
    
    func deleteTodo(_ item: Todo) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
            
            do {
                if let results = try self.context.fetch(request).first {
                    self.context.delete(results)
                    try self.context.save()
                    promise(.success(()))
                } else {
                    promise(.failure(NSError(domain: "Todo not found", code: 404, userInfo: nil)))
                }
            } catch {
                print("Error deleting todos: \(error)")
                promise(.failure(error))
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    
    
    
}
