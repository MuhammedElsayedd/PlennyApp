//
//  LoginUseCaseTests.swift
//  PlenyAppTests
//
//  Created by Muhammed Elsayed on 20/07/2025.
//

import XCTest
import Combine
@testable import PlenyApp

final class LoginUseCaseTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func test_login_success() {
        let mock = MockAuthRepository()
        let useCase = LoginUseCase(repository: mock)
        let expectation = XCTestExpectation(description: "Login success")

        useCase.execute(username: "emilys", password: "emilyspass")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got failure: \(error)")
                }
            }, receiveValue: { user in
                XCTAssertEqual(user.username, "testuser")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_login_failure() {
        let mock = MockAuthRepository()
        mock.shouldReturnError = true
        let useCase = LoginUseCase(repository: mock)
        let expectation = XCTestExpectation(description: "Login failure")

        useCase.execute(username: "wrong", password: "wrong")
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Should not return user")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
