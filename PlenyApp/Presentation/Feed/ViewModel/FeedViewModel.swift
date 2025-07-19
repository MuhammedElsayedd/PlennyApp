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
    @Published var searchQuery: String = ""
    @Published var isSearching: Bool = false

    private let repository = FeedRepository()
    private var currentPage = 0
    private let limit = 10
    private var hasMorePages = true
    private var cancellables = Set<AnyCancellable>()

    init() {
        bindSearch()
        fetchPosts()
    }

    private func bindSearch() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }
                self.posts = []
                self.currentPage = 0
                self.hasMorePages = true
                self.isSearching = !query.isEmpty
                if self.isSearching {
                    self.searchPosts()
                } else {
                    self.fetchPosts()
                }
            }
            .store(in: &cancellables)
    }

    func fetchPosts() {
        guard !isLoading, hasMorePages, !isSearching else { return }
        isLoading = true
        repository.fetchPosts(limit: limit, skip: currentPage * limit)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: appendPosts)
            .store(in: &cancellables)
    }

    func searchPosts() {
        guard !isLoading, hasMorePages, isSearching else { return }
        isLoading = true
        repository.searchPosts(query: searchQuery, limit: limit, skip: currentPage * limit)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: appendPosts)
            .store(in: &cancellables)
    }

    func fetchNextPageIfNeeded(currentPost: PostUIModel) {
        guard !isLoadingNextPage,
              currentPost == posts.suffix(3).first else { return }

        isLoadingNextPage = true
        let publisher: AnyPublisher<[Post], Error> = isSearching
            ? repository.searchPosts(query: searchQuery, limit: limit, skip: (currentPage + 1) * limit)
            : repository.fetchPosts(limit: limit, skip: (currentPage + 1) * limit)

        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoadingNextPage = false
                if case .failure(let error) = completion {
                    print("❌ Pagination error:", error)
                }
            }, receiveValue: appendPosts)
            .store(in: &cancellables)
    }

    func refresh() {
        posts = []
        currentPage = 0
        hasMorePages = true
        isSearching ? searchPosts() : fetchPosts()
    }

    private func appendPosts(_ newPosts: [Post]) {
        let mapped = newPosts.map(PostUIModel.init)
        posts.append(contentsOf: mapped)
        currentPage += 1
        hasMorePages = !newPosts.isEmpty
        isLoading = false
    }

    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        isLoading = false
        if case .failure(let error) = completion {
            print("❌ Error:", error)
        }
    }
}
