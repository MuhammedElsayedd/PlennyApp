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
                    logoView

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
    
    private var logoView: some View {
        Text("LOGO")
            .font(.title2.bold())
            .foregroundStyle(
                LinearGradient(
                    stops: [
                        .init(color: Color(red: 0.31, green: 0.38, blue: 0.92).opacity(0.9), location: 0.0),
                        .init(color: Color(red: 0.76, green: 0.23, blue: 0.85).opacity(0.9), location: 1.0)
                    ],
                    startPoint: UnitPoint(x: 1.47, y: 0.47),
                    endPoint: UnitPoint(x: 0.47, y: -0.47)
                )
            )
    }
}


#Preview {
    FeedView(appCoordinator: AppCoordinator())
}
