//
//  EventRepository.swift
//  CleanArchWeatherApp
//
//  Created by Ademola Kolawole on 19/07/2024.
//

import Combine

protocol TodoRepository {
    func getAllTodos() -> AnyPublisher<[Todo], Error>
    func addTodo(_ item: Todo) -> AnyPublisher<Void, Error>
    func updateTodo(_ item: Todo) -> AnyPublisher<Void, Error>
    func deleteTodo(_ item: Todo) -> AnyPublisher<Void, Error>
}
