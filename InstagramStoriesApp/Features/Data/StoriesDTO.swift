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
                ]),
                Page(users: [
                    User(id: 11, name: "User 11", imageUrl: "https://i.pravatar.cc/300?u=10"),
                    User(id: 12, name: "User 12", imageUrl: "https://i.pravatar.cc/300?u=20"),
                    User(id: 13, name: "User 13", imageUrl: "https://i.pravatar.cc/300?u=30"),
                    User(id: 14, name: "User 14", imageUrl: "https://i.pravatar.cc/300?u=40"),
                    User(id: 15, name: "User 15", imageUrl: "https://i.pravatar.cc/300?u=50"),
                    User(id: 16, name: "User 16", imageUrl: "https://i.pravatar.cc/300?u=60"),
                    User(id: 17, name: "User 17", imageUrl: "https://i.pravatar.cc/300?u=70"),
                    User(id: 18, name: "User 18", imageUrl: "https://i.pravatar.cc/300?u=80"),
                    User(id: 19, name: "User 19", imageUrl: "https://i.pravatar.cc/300?u=90"),
                    User(id: 20, name: "User 20", imageUrl: "https://i.pravatar.cc/300?u=100")
                ]),
                Page(users: [
                    User(id: 21, name: "User 21", imageUrl: "https://i.pravatar.cc/300?u=10"),
                    User(id: 22, name: "User 22", imageUrl: "https://i.pravatar.cc/300?u=20"),
                    User(id: 23, name: "User 23", imageUrl: "https://i.pravatar.cc/300?u=30"),
                    User(id: 24, name: "User 24", imageUrl: "https://i.pravatar.cc/300?u=40"),
                    User(id: 25, name: "User 25", imageUrl: "https://i.pravatar.cc/300?u=50"),
                    User(id: 26, name: "User 26", imageUrl: "https://i.pravatar.cc/300?u=60"),
                    User(id: 27, name: "User 27", imageUrl: "https://i.pravatar.cc/300?u=70"),
                    User(id: 28, name: "User 28", imageUrl: "https://i.pravatar.cc/300?u=80"),
                    User(id: 29, name: "User 29", imageUrl: "https://i.pravatar.cc/300?u=90"),
                    User(id: 30, name: "User 30", imageUrl: "https://i.pravatar.cc/300?u=100")
                ])
            ]
        }
    }
}

extension DTO.Stories.Response {
    struct Page {
        let users: [User]
    }

    struct User: Identifiable, Hashable {
        let id: Int
        let name: String
        let imageUrl: String
        
        static func == (lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id
        }
    }
}
