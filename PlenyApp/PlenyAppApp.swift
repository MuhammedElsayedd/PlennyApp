//
//  PlenyAppApp.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import SwiftUI

@main
struct PlenyAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
