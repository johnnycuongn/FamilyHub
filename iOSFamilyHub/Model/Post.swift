//
//  Post.swift
//  iOSFamilyHub
//
//  Created by Johnny on 5/9/2023.
//

import Foundation

struct Post : Identifiable, Decodable {
    let id: UUID
    let author : String
    let imagePath: String
    let date: Date
    let location: String
    let description: String
    var isLike: Bool = false
}
