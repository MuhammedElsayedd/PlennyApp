//
//  FeedCoordinator.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

final class FeedCoordinator: ObservableObject {
    let view: AnyView

    init(appCoordinator: AppCoordinator) {
        self.view = AnyView(FeedView(appCoordinator: appCoordinator))
    }
}
