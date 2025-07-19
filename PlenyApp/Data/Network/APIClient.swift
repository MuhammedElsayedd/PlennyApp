//
//  APIClient.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import Foundation
import Combine

final class APIClient {
    static let shared = APIClient()

    private init() {}

    // For requests WITHOUT body (GET)
    func requestPublisher<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        requiresAuth: Bool = true
    ) -> AnyPublisher<T, Error> {
        requestPublisher(url: url, method: method, body: EmptyBody(), requiresAuth: requiresAuth)
    }

    // For requests WITH body (POST/PUT)
    func requestPublisher<T: Decodable, U: Encodable>(
        url: URL,
        method: HTTPMethod,
        body: U,
        requiresAuth: Bool = true
    ) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        if requiresAuth,
           let token = KeychainHelper.get(for: "accessToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        do {
            if !(body is EmptyBody) {
                request.httpBody = try JSONEncoder().encode(body)
            }
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                if let httpResponse = result.response as? HTTPURLResponse,
                   !(200...299).contains(httpResponse.statusCode) {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
