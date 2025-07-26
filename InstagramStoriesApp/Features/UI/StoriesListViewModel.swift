//
//  StoriesListViewModel.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation


protocol StoriesListViewModelProtocol {
    func fetchStories() async
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
    
    private(set) var viewState: State = .idle
    private let useCase: StoriesListUseCaseProtocol
    
    init(useCase: StoriesListUseCaseProtocol = StoryListUseCaseImpl()) {
        self.useCase = useCase
    }
}

// MARK: - StoriesListViewModelProtocol
extension StoriesListViewModelImpl: StoriesListViewModelProtocol {
    func fetchStories() async {
        viewState = .loading
        
        do {
            let pages: [DTO.Stories.Response.Page] = try await useCase.fetchStories()
            if let firstPage = pages.first {
                viewState = .result(firstPage.users)
            } else {
                viewState = .empty
            }
        } catch {
            viewState = .error(error)
        }
    }
}

