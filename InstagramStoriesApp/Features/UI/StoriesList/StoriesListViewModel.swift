//
//  StoriesListViewModel.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation


protocol StoriesListViewModelProtocol {
    func fetchStories() async
    func checkStorySeen(id: Int) -> Bool
    func makeStoryAsSeen(id: Int)
    func checkAndLoadMoreStories() async
}

@Observable
final class StoriesListViewModelImpl {
    enum State {
        case idle
        case loading
        case result([UI.Stories.User])
        case empty
        case error(Error)
    }
    
    private var currentPage = 0
    private var totalPages = 0
    private var isAllowedToLoadMore = true
    private var totalUsers: [UI.Stories.User] = []
    private(set) var seenStories: Set<Int> = []
    private(set) var viewState: State = .idle
    private let useCase: StoriesListUseCaseProtocol
    
    init(useCase: StoriesListUseCaseProtocol = StoryListUseCaseImpl()) {
        self.useCase = useCase
    }
}

// MARK: - StoriesListViewModelProtocol
extension StoriesListViewModelImpl: StoriesListViewModelProtocol {
    func fetchStories() async {
        do {
            let pages: [DTO.Stories.Response.Page] = try await useCase.fetchStories()
            
            if self.isAllowedToLoadMore {
                let currentPage = pages[currentPage]
                let transformedUsers = currentPage.toUIModel() // Tarnsform DTO to UI model
                self.totalUsers += transformedUsers
                self.currentPage += 1
                self.isAllowedToLoadMore = pages.count > self.currentPage
                
                await MainActor.run {
                    if totalUsers.isEmpty {
                        viewState = .empty
                    } else {
                        viewState = .result(self.totalUsers)
                    }
                }
            } 
        } catch {
            await MainActor.run {
                viewState = .error(error)
            }
        }
    }
    
    func checkStorySeen(id: Int) -> Bool {
        seenStories.contains(id)
    }
    
    func makeStoryAsSeen(id: Int) {
        seenStories.insert(id)
    }
    
    func checkAndLoadMoreStories() async {
        if isAllowedToLoadMore {
            await fetchStories()
        } else {
            resetPagination() // Reset pagination if no more stories to load infinitely
            await fetchStories()
        }
    }
    
    // MARK: - Pagination Reset
    // Resets the pagination state to allow fetching stories from the beginning.
    func resetPagination() {
        currentPage = 0
        isAllowedToLoadMore = true
    }
}

