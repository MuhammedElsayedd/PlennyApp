//
//  MockAuthRepository.swift
//  PlenyAppTests
//
//  Created by Muhammed Elsayed on 20/07/2025.
//

import XCTest
import Combine
@testable import PlenyApp

final class MockAuthRepository: AuthRepositoryProtocol {
    var shouldReturnError = false
    let dummyUser = User(
        id: 1,
        username: "testuser",
        email: "test@example.com",
        firstName: "Test",
        lastName: "User",
        gender: "male",
        image: "https://example.com/image.png",
        accessToken: "mock_access_token",
        refreshToken: "mock_refresh_token"
    )

    func login(username: String, password: String) -> AnyPublisher<User, Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        } else {
            return Just(dummyUser)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
