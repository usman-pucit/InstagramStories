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
        case result([DTO.Stories.Response.User])
        case empty
        case error(Error)
    }
    
    private var currentPage = 0
    private var totalPages = 0
    private var isAllowedToLoadMore = true
    private var totalUsers: [DTO.Stories.Response.User] = []
    private(set) var seenStories: Set<Int> = []
    private(set) var viewState: State = .idle
    private let useCase: StoriesListUseCaseProtocol
    
    init(useCase: StoriesListUseCaseProtocol = StoryListUseCaseImpl()) {
        self.useCase = useCase
    }
}

// MARK: - StoriesListViewModelProtocol
extension StoriesListViewModelImpl: StoriesListViewModelProtocol {
    @MainActor
    func fetchStories() async {
        do {
            let pages: [DTO.Stories.Response.Page] = try await useCase.fetchStories()
            
            if self.isAllowedToLoadMore {
                let currentPage = pages[currentPage]
                let users = currentPage.users
                self.totalUsers += users
                self.currentPage += 1
                self.isAllowedToLoadMore = pages.count > self.currentPage
                
                if totalUsers.isEmpty {
                    viewState = .empty
                } else {
                    viewState = .result(self.totalUsers)
                }
            } 
        } catch {
            viewState = .error(error)
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
        }
    }
}

