//
//  AppCoordinator.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import Foundation
import SwiftUI
import SwiftUICore

final class AppCoordinator: ObservableObject {
    @Published var currentView: AnyView = AnyView(EmptyView())

    func start() {
        if let _ = KeychainHelper.get(for: "accessToken") {
            showFeed()
        } else {
            showLogin()
        }
    }

    func showLogin() {
        let loginCoordinator = LoginCoordinator(appCoordinator: self)
        currentView = AnyView(loginCoordinator.view)
    }

    func showFeed() {
        let feedCoordinator = FeedCoordinator(appCoordinator: self)
        currentView = AnyView(feedCoordinator.view)
    }
    
    func logout() {
        KeychainHelper.remove(for: "accessToken")
        KeychainHelper.remove(for: "refreshToken")
        showLogin()
    }
}
