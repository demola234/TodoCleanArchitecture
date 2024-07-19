//
//  EventUsecase.swift
//  CleanArchWeatherApp
//
//  Created by Ademola Kolawole on 19/07/2024.
//

import Foundation

struct EventUseCases: EventRepository {
    var repo: EventRepository
    
    func getEvents() -> [Event] {
        return repo.getEvents()
    }
    
    func createEvent(event: Event) -> Event? {
        return repo.createEvent(event: event)
    }
    
}
