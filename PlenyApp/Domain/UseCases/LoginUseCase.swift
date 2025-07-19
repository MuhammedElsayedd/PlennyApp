//
//  LoginUseCase.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import Foundation
import Combine

final class LoginUseCase {
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }

    func execute(username: String, password: String) -> AnyPublisher<User, Error> {
        repository.login(username: username, password: password)
    }
}
