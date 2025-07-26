//
//  StoriesListUseCase.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation

protocol StoriesListUseCaseProtocol {
    func fetchStories() async throws -> [Int]
}

final class StoryListUseCaseImpl {
    private let repository: StoriesListRepositoryProtocol
    
    init(
        repository: StoriesListRepositoryProtocol = StoriesListRepositoryImpl()
    ) {
        self.repository = repository
    }
}

extension StoryListUseCaseImpl: StoriesListUseCaseProtocol {
    func fetchStories() async throws -> [Int] {
        try await repository.fetchStories()
    }
}
   
