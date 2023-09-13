//
//  EventViewModel.swift
//  iOSFamilyHub
//
//  Created by Johnny on 13/9/2023.
//

import Foundation

enum EventsViewModelError: Error {
    case invalidTitle
    case invalidLocation
    case invalidDescription
}

protocol EventsViewModelInterface: ObservableObject {
    var events: [Event] {get set}
}

class EventViewModel: ObservableObject, EventsViewModelInterface {
    @Published var events: [Event] = []
    
    func addEvent(title: String, date: Date, location: String, organiser: String, members: Array<String>, description: String) throws {
        let id = UUID()
        
        // EVENT VALIDATION
        if (title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            throw EventsViewModelError.invalidTitle
        }
        
        if (location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            throw EventsViewModelError.invalidLocation
        }
        
        if (description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            throw EventsViewModelError.invalidDescription
        }
        
        let newEvent = Event(id: id, title: title, date: date, location: location, organiser: organiser, members: members, description: description)
        events.append(newEvent)
    }

}
