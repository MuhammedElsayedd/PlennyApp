//
//  FetchFeedUseCaseTests.swift
//  PlenyAppTests
//
//  Created by Muhammed Elsayed on 20/07/2025.
//

import XCTest
import Combine
@testable import PlenyApp

final class FetchFeedUseCaseTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func test_fetchPosts_success() {
        let mockRepo = MockFeedRepository()
        let useCase = FetchFeedUseCase(repository: mockRepo)
        let expectation = XCTestExpectation(description: "Fetch posts success")

        useCase.execute(limit: 10, skip: 0)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            }, receiveValue: { posts in
                XCTAssertEqual(posts.count, 1)
                XCTAssertEqual(posts.first?.title, "Test title")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchPosts_failure() {
        let mockRepo = MockFeedRepository()
        mockRepo.shouldReturnError = true
        let useCase = FetchFeedUseCase(repository: mockRepo)
        let expectation = XCTestExpectation(description: "Fetch posts failure")

        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Should not return posts")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
