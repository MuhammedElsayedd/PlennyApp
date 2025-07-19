//
//  FeedView.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

struct FeedView: View {
    let appCoordinator: AppCoordinator
    @StateObject private var viewModel = FeedViewModel()
    
    @State private var selectedImage: ImageSource?
    @State private var selectedUserId: Int?
    @State private var isSearchBarVisible = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                if isSearchBarVisible {
                    SearchBarView(
                        text: $viewModel.searchQuery,
                        onClear: {
                            viewModel.searchQuery = ""
                            isSearchBarVisible = false
                        }
                    )
                } else {
                    Text("LOGO")
                        .font(.title2.bold())
                        .foregroundStyle(.indigo)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            isSearchBarVisible = true
                        }
                    } label: {
                        Image("searchIcon")
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.posts) { post in
                        PostCardView(
                            post: post,
                            onProfileTap: {
                                if let image = post.userImage {
                                    selectedImage = .profile(image)
                                }
                            },
                            onImageTap: { image in
                                selectedImage = .post(image)
                            }
                        )
                        .onAppear {
                            viewModel.fetchNextPageIfNeeded(currentPost: post)
                        }
                    }
                    
                    if viewModel.isLoadingNextPage {
                        ProgressView().padding()
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    FeedView(appCoordinator: AppCoordinator())
}
