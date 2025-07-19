//
//  LoginCoordinator.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import SwiftUI

final class LoginCoordinator: ObservableObject {
    let view: AnyView

    init(appCoordinator: AppCoordinator) {
        let viewModel = LoginViewModel()
        viewModel.appCoordinator = appCoordinator
        self.view = AnyView(LoginView(viewModel: viewModel))
    }
}
