//
//  StoriesListUseCase.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation

protocol StoriesListUseCaseProtocol {
    func fetchStories() async throws -> [DTO.Stories.Response.Page]
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
    func fetchStories() async throws -> [DTO.Stories.Response.Page] {
        try await repository.fetchStories()
    }
}
   
