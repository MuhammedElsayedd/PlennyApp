//
//  AuthRepository.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import Foundation
import Combine
final class AuthRepository: AuthRepositoryProtocol {
    func login(username: String, password: String) -> AnyPublisher<User, Error> {
        guard let url = URL(string: Endpoints.baseURL + Endpoints.Auth.login) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let request = LoginRequest(username: username, password: password)

        return APIClient.shared
            .requestPublisher(url: url, method: .POST, body: request, requiresAuth: false)
    }
}
