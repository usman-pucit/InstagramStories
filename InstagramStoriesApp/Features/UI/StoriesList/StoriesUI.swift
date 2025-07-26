//
//  StoriesUI.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation

enum UI {
    enum Stories { }
}

extension UI.Stories {
    struct User: Identifiable, Hashable {
        let id: Int
        let name: String
        let imageUrl: String
    }
}

extension UI.Stories.User: Equatable {
    static func == (lhs: UI.Stories.User, rhs: UI.Stories.User) -> Bool {
        return lhs.id == rhs.id
    }
}

extension DTO.Stories.Response.Page {
    func toUIModel() -> [UI.Stories.User] {
        self.users.map { user in
            UI.Stories.User(
                id: user.id,
                name: user.name,
                imageUrl: user.imageUrl
            )
        }
    }
}


