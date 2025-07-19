//
//  AuthRepositoryProtocol.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Combine
protocol AuthRepositoryProtocol {
    func login(username: String, password: String) -> AnyPublisher<User, Error>
}
