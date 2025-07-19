//
//  PostUIModel.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Foundation

struct PostUIModel: Identifiable, Equatable {
    let id: Int?
    let username: String?
    let userImage: String?
    let timeAgo: String?
    let body: String?
    let postImages: [String]?
    let likes: Int?
    let dislikes: Int?
    let tags: [String]?
    let views: Int?

    init(from post: Post) {
        self.id = post.id

        let userId = post.userId
        self.username = userId != nil ? "User \(userId!)" : "User"
        self.userImage = Self.getProfileImage(userId: userId)

        self.timeAgo = "Just now"
        self.body = post.body
        self.postImages = Self.getPostImages(for: post.id)

        self.likes = post.reactions?.likes
        self.dislikes = post.reactions?.dislikes
        self.tags = post.tags
        self.views = post.views
    }

    private static func getProfileImage(userId: Int?) -> String {
        guard let userId = userId else { return "defaultUser" }
        return "user\(userId % 2 + 1)"
    }

    private static func getPostImages(for id: Int?) -> [String] {
        guard let id = id else { return [] }

        switch id % 3 {
        case 0:
            return ["img1", "img2", "img3"]
        case 1:
            return ["img4"]
        case 2:
            return ["img1", "img2"]
        default:
            return []
        }
    }
}
