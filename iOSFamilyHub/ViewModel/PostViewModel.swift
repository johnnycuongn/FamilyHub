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
    @Published var posts: [Post] = []

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

// Define a Store class that conforms to the ObservableObject protocol
//class Store: ObservableObject {
//
//    // A published property that will store an array of Product instances
//    @Published var products: [Product]
//
//
//    // Define the initializer for the Store class
//    init(filename: String = "ProductData.json") {
//        let decoder = JSONDecoder()
//        guard let url = Bundle.main.url(forResource: filename, withExtension: nil),
//              let data = try? Data(contentsOf: url),
//              let products = try? decoder.decode([Product].self, from: data)
//        else {
//            self.products = []
//            return
//        }
//        self.products = products
//    }
//
//    
//    // Define a function to toggle the 'isFavorite' property of a given product
//    func toggleFavorite(product: Product) {
//        if let index = products.firstIndex(where: { $0.id == product.id }) {
//            products[index].isFavorite.toggle()
//        }
//    }
//
//}
