//
//  MainTabCoordinator.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

final class MainTabCoordinator {
    private let viewModel = MainTabViewModel()
    private let appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    var view: some View {
        MainTabView(appCoordinator: appCoordinator, viewModel: viewModel)
    }
}
