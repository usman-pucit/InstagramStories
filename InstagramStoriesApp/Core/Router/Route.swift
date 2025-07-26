//
//  Route.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import Foundation

enum Route: Identifiable, Hashable {
    var id: Self { self }
    
    case storiesList
    case storyView(user: UI.Stories.User)
}
