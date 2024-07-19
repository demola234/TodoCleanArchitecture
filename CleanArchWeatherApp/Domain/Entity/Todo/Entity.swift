//
//  Entity.swift
//  CleanArchWeatherApp
//
//  Created by Ademola Kolawole on 19/07/2024.
//

import Foundation

struct Todo: Identifiable {
    var id: UUID = .init()
    var title: String
    var description: String
    var isCompleted: Bool
}
