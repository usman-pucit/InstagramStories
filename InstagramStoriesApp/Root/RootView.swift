//
//  RootView.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//


import SwiftUI

struct RootView: View {
    @StateObject private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            StoriesListView()
                .navigationDestination(for: Route.self) { route in
                    destinationView(for: route)
                }
                .fullScreenCover(item: $router.fullScreen) { route in
                    destinationView(for: route)
                }
        }
        .background(Color(.systemBackground))
        .environmentObject(router)
    }
    
    @ViewBuilder
    func destinationView(for route: Route) -> some View {
        switch route {
        case .storiesList:
            StoriesListView()
        case .storyView(let user):
            StoryViewScreen(user: user)
        }
    }
}

