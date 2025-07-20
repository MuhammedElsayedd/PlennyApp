//
//  Post.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Foundation
struct PostsResponse: Decodable {
    let posts: [Post]
}
struct Post: Identifiable, Decodable {
    let id: Int?
    let body: String?
    let title: String?
    let userId: Int?
    let image: String?
}
