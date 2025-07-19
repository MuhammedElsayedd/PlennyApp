//
//  AuthRepositoryProtocol.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Foundation
protocol AuthRepositoryProtocol {
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
