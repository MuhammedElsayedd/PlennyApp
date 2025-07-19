//
//  FeedRepositoryProtocol.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Combine
protocol FeedRepositoryProtocol {
    func fetchPosts(limit: Int, skip: Int) -> AnyPublisher<[Post], Error>
}
