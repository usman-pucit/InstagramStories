//
//  StoriesDTO.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation

enum DTO {
    enum Stories { }
}

extension DTO.Stories {
    struct Response {
        static var pages: [Page] {
            return [
                Page(users: [
                    User(id: 1, name: "User 1", imageUrl: "https://i.pravatar.cc/300?u=10"),
                    User(id: 2, name: "User 2", imageUrl: "https://i.pravatar.cc/300?u=20"),
                    User(id: 3, name: "User 3", imageUrl: "https://i.pravatar.cc/300?u=30"),
                    User(id: 4, name: "User 4", imageUrl: "https://i.pravatar.cc/300?u=40"),
                    User(id: 5, name: "User 5", imageUrl: "https://i.pravatar.cc/300?u=50"),
                    User(id: 6, name: "User 6", imageUrl: "https://i.pravatar.cc/300?u=60"),
                    User(id: 7, name: "User 7", imageUrl: "https://i.pravatar.cc/300?u=70"),
                    User(id: 8, name: "User 8", imageUrl: "https://i.pravatar.cc/300?u=80"),
                    User(id: 9, name: "User 9", imageUrl: "https://i.pravatar.cc/300?u=90"),
                    User(id: 10, name: "User 10", imageUrl: "https://i.pravatar.cc/300?u=100")
                ])
            ]
        }
    }
}

extension DTO.Stories.Response {
    struct Page {
        let users: [User]
    }

    struct User: Identifiable {
        let id: Int
        let name: String
        let imageUrl: String
    }
}
