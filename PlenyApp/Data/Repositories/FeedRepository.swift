//
//  FeedRepository.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Foundation
import Combine

final class FeedRepository: FeedRepositoryProtocol {
    func fetchPosts(limit: Int, skip: Int) -> AnyPublisher<[Post], Error> {
        let urlString = "\(Endpoints.baseURL)/posts?limit=\(limit)&skip=\(skip)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return APIClient.shared
            .requestPublisher(url: url, method: .GET)
            .map { (response: PostsResponse) in
                response.posts
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
