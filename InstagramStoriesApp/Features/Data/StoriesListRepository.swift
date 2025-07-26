//
//  StoriesListRepository.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation

protocol StoriesListRepositoryProtocol {
    func fetchStories() async throws -> [DTO.Stories.Response.Page]
}

final class StoriesListRepositoryImpl: StoriesListRepositoryProtocol {
    func fetchStories() async throws -> [DTO.Stories.Response.Page] {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                let response = DTO.Stories.Response.pages
                
                continuation.resume(returning: response)
            }
        }
    }
}
