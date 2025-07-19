//
//  FeedView.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

struct FeedView: View {
    let appCoordinator: AppCoordinator
    var body: some View {
        VStack {
            Spacer()
            Text("Feed Screen")
                .font(.largeTitle)
                .foregroundColor(.purple)
            Spacer()
            Button("Logout") {
                appCoordinator.logout()
            }
            .padding()
            .foregroundColor(.red)
        }
    }
}

#Preview {
    FeedView(appCoordinator: AppCoordinator())
}
