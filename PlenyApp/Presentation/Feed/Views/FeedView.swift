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

    var body: some View {
        VStack {
            header
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

                        Divider()
                    }

                    if viewModel.isLoadingNextPage {
                        ProgressView()
                            .padding()
                    }
                }
            }
        }
        .fullScreenCover(item: $selectedImage) { image in
            ZStack(alignment: .topTrailing) {
                Image(image.name)
                    .resizable()
                    .scaledToFit()

                Button(action: {
                    selectedImage = nil
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 30))
                        .padding()
                }
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("LOGO")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.purple)

            Spacer()

            Button(action: {
                // TODO: Navigate to search
            }) {
                Image("searchIcon")
            }
        }
        .padding()
    }
}

#Preview {
    FeedView(appCoordinator: AppCoordinator())
}
