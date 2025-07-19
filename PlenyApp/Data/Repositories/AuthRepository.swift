//
//  AuthRepository.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import Foundation
final class AuthRepository: AuthRepositoryProtocol {
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: Endpoints.baseURL + Endpoints.Auth.login) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0)))
            return
        }

        let request = LoginRequest(username: username, password: password)
        APIClient.shared.post(url: url, body: request, requiresAuth: false, completion: completion)
    }
}
