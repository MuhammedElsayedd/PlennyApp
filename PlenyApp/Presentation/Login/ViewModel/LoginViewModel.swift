//
//  LoginViewModel.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import Foundation
import Combine

@Observable
final class LoginViewModel: ObservableObject {
    var username: String = "emilys" // MARK: For easy testing purpose
    var password: String = "emilyspass" // MARK: For easy testing purpose
    var isPasswordHidden: Bool = true
    var isLoading: Bool = false
    var errorMessage: String?

    private let loginUseCase = LoginUseCase()
    private var cancellables = Set<AnyCancellable>()
    
    weak var appCoordinator: AppCoordinator?

    func login() {
        isLoading = true
        errorMessage = nil

        loginUseCase.execute(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false

                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }

                if let accessToken = user.accessToken {
                    KeychainHelper.save(accessToken, for: "accessToken")
                }

                if let refreshToken = user.refreshToken {
                    KeychainHelper.save(refreshToken, for: "refreshToken")
                }

                if let encoded = try? JSONEncoder().encode(user) {
                    UserDefaults.standard.set(encoded, forKey: "loggedInUser")
                }

                self.appCoordinator?.showFeed()
            }
            .store(in: &cancellables)
    }
}
