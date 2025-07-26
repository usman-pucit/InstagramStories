//
//  NavigationRouter.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import SwiftUI

class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var fullScreen: Route? = nil
    
    func presentFullScreen(_ route: Route) {
        fullScreen = route
    }
    
    func dismissFullScreen() {
        fullScreen = nil
    }
}
