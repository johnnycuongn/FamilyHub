//
//  Post.swift
//  iOSFamilyHub
//
//  Created by Johnny on 5/9/2023.
//

import Foundation
import UIKit

protocol Interactable {
    var isLike: Bool { get }
}

protocol DisplayablePostInterface: Interactable {
    var author: String { get }
    var date: Date { get }
    var location: String { get }
    var description: String { get }
    var isLike: Bool { get }
}

extension DisplayablePostInterface {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
}

struct Post : DisplayablePostInterface, Identifiable, Decodable {
    let id: UUID
    let author : String
    let imagePath: String
    let date: Date
    let location: String
    let description: String
    var isLike: Bool = false
    

}
