//
//  FeedViewModel.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Foundation
import Combine

final class FeedViewModel: ObservableObject {
    @Published var posts: [PostUIModel] = []
    @Published var isLoading = false
    @Published var isLoadingNextPage = false

    private let repository = FeedRepository()
    private var currentPage = 0
    private let limit = 10
    private var hasMorePages = true
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchPosts()
    }

    func fetchPosts() {
        guard !isLoading, hasMorePages else { return }
        isLoading = true

        repository.fetchPosts(limit: limit, skip: currentPage * limit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("❌ Failed to fetch posts:", error)
                }
            } receiveValue: { [weak self] newPosts in
                self?.appendPosts(newPosts)
            }
            .store(in: &cancellables)
    }

    func fetchNextPageIfNeeded(currentPost: PostUIModel) {
        guard !isLoadingNextPage,
              currentPost == posts.suffix(3).first else { return }

        isLoadingNextPage = true

        repository.fetchPosts(limit: limit, skip: (currentPage + 1) * limit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingNextPage = false
                if case .failure(let error) = completion {
                    print("❌ Pagination error:", error)
                }
            } receiveValue: { [weak self] newPosts in
                self?.appendPosts(newPosts)
            }
            .store(in: &cancellables)
    }

    func refresh() {
        posts = []
        currentPage = 0
        hasMorePages = true
        fetchPosts()
    }

    private func appendPosts(_ newPosts: [Post]) {
        let mapped = newPosts.map { PostUIModel(from: $0) }
        posts.append(contentsOf: mapped)
        currentPage += 1
        hasMorePages = !newPosts.isEmpty
    }
}
