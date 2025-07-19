//
//  FetchFeedUseCase.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Foundation
import Combine

final class FetchFeedUseCase {
    private let repository: FeedRepositoryProtocol

    init(repository: FeedRepositoryProtocol = FeedRepository()) {
        self.repository = repository
    }

    func execute(limit: Int = 10, skip: Int = 0) -> AnyPublisher<[Post], Error> {
        repository.fetchPosts(limit: limit, skip: skip)
    }
}
