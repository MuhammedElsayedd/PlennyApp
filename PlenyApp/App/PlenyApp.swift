//
//  PlenyApp.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import SwiftUI

@main
struct PlenyApp: App {
    @StateObject var appCoordinator = AppCoordinator()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.currentView
                .onAppear {
                    appCoordinator.start()
                }
        }
    }
}
