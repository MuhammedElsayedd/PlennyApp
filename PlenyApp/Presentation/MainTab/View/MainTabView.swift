//
//  MainTabView.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

struct MainTabView: View {
    let appCoordinator: AppCoordinator
    @ObservedObject var viewModel: MainTabViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            FeedCoordinator(appCoordinator: appCoordinator).view
                .tabItem {
                    Image(viewModel.selectedTab == .feed ? "selectedFeed" : "unselectedFeed")
                }
                .tag(MainTab.feed)

            placeholder("Shop")
                .tabItem {
                    Image(viewModel.selectedTab == .shop ? "selectedShop" : "shop")
                }
                .tag(MainTab.shop)

            placeholder("Offers")
                .tabItem {
                    Image(viewModel.selectedTab == .offers ? "selectedOffer" : "offer")
                }
                .tag(MainTab.offers)

            placeholder("Gallery")
                .tabItem {
                    Image(viewModel.selectedTab == .gallery ? "selectedGallery" : "gallery")
                }
                .tag(MainTab.gallery)

            hireMeTab
                .tabItem {
                    Image(viewModel.selectedTab == .profile ? "selectedProfile" : "profile")
                }
                .tag(MainTab.profile)
        }
    }

    private func placeholder(_ name: String) -> some View {
        VStack {
            Spacer()
            Text(name)
                .font(.title)
                .foregroundColor(.gray)
            Text("Coming soon...")
                .foregroundColor(.secondary)
            Spacer()
        }
    }

    private var hireMeTab: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("👋 Hello!")
                .font(.title2)
                .fontWeight(.bold)
            Text("Like what you see?\nHire me and I’ll integrate the rest of the tabs too!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
        }
    }
}

#Preview {
    MainTabView(
        appCoordinator: AppCoordinator(),
        viewModel: MainTabViewModel()
    )
}
