//
//  StoriesListRepository.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation

protocol StoriesListRepositoryProtocol {
    func fetchStories() async throws -> [Int]
}

final class StoriesListRepositoryImpl: StoriesListRepositoryProtocol {    
    func fetchStories() async throws -> [Int] {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                // Simulating a network call or data fetch
                continuation.resume(returning: [1,2,3,4,5])
            }
        }
    }
}
