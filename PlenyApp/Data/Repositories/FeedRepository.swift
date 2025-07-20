//
//  FeedRepository.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Foundation
import Combine

final class FeedRepository: FeedRepositoryProtocol {
    private let cache = CoreDataFeedCache()

    func fetchPosts(limit: Int, skip: Int) -> AnyPublisher<[Post], Error> {
        let urlString = "\(Endpoints.baseURL)/posts?limit=\(limit)&skip=\(skip)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return APIClient.shared
            .requestPublisher(url: url, method: .GET)
            .map { (response: PostsResponse) in
                self.cache.save(posts: response.posts)
                return response.posts
            }
            .catch { error in
                let cachedPosts = self.cache.fetch()
                return Just(cachedPosts)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func searchPosts(query: String, limit: Int, skip: Int) -> AnyPublisher<[Post], Error> {
        let urlString = "\(Endpoints.baseURL)/posts/search?q=\(query)&limit=\(limit)&skip=\(skip)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return APIClient.shared
            .requestPublisher(url: url, method: .GET)
            .map { (response: PostsResponse) in response.posts }
            .eraseToAnyPublisher()
    }
}
