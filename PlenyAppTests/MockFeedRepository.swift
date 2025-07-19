//
//  MockFeedRepository.swift
//  PlenyAppTests
//
//  Created by Muhammed Elsayed on 20/07/2025.
//

import Combine
@testable import PlenyApp
import Foundation

final class MockFeedRepository: FeedRepositoryProtocol {
    var shouldReturnError = false
    var dummyPosts: [Post] = [
        Post(
            id: 1,
            body: "Test body",
            title: "Test title",
            userId: 1,
            tags: ["test"],
            reactions: Reactions(likes: 10, dislikes: 1),
            views: 100,
            image: "https://example.com/image.jpg"
        )
    ]
    
    func fetchPosts(limit: Int, skip: Int) -> AnyPublisher<[Post], Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            return Just(dummyPosts)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    func searchPosts(query: String, limit: Int, skip: Int) -> AnyPublisher<[Post], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
