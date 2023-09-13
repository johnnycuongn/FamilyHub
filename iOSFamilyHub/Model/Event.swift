//
//  Event.swift
//  iOSFamilyHub
//
//  Created by Johnny on 13/9/2023.
//

import Foundation

protocol DisplayableEventInterface {
    var id: UUID { get }
    var title: String { get }
    var date: Date { get }
    var location: String { get }
    var organiser: String { get }
    var members: Array<String> { get }
    var description: String { get }
}

struct Event: DisplayableEventInterface, Identifiable, Decodable {
    let id: UUID
    let title: String
    let date: Date
    let location: String
    let organiser: String
    let members: Array<String>
    let description: String
}
