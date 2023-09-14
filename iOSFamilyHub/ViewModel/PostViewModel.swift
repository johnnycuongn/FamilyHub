//
//  PostViewModel.swift
//  iOSFamilyHub
//
//  Created by Johnny on 6/9/2023.
//

import Foundation
import UIKit

enum PostViewModelError: Error {
    case invalidDescription
    case invalidLocation
}

protocol PostViewModelInterface: ObservableObject {
    var posts: [Post] {get set}
}

class PostViewModel: ObservableObject, PostViewModelInterface {
    @Published var posts: [Post] = [
        Post(id: UUID(), author: "Johnny Nguyen", imagePath: "", date: Date(), location: "Sydney", description: "I will graduate in 2024. Hurray!!")
    ]

     func addPost(author: String, description: String, location: String, image: UIImage?) throws {
         let id = UUID()
         print("Adding new post")
         
         // POST VALIDATION
         if (description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
             throw PostViewModelError.invalidDescription
         }
         if (location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
             throw PostViewModelError.invalidLocation
         }
         
         let newPost = Post(id: id, author: author, imagePath: "", date: Date(), location: location, description: description)
         posts.append(newPost)
     }
    
}
