//
//  StoriesListView.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import SwiftUI

struct StoriesListView: View {
    @State private var viewModel = StoriesListViewModelImpl()
    @State private var selectedStory: DTO.Stories.Response.User?
    @State private var showStoryView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                contentView
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Stories")
        }
        .task {
            await viewModel.fetchStories()
        }
        .background(Color(.systemBackground))
    }
    
    // MARK: - Private Views
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.viewState {
        case .idle, .loading:
            loadingView
        case .error(_):
            errorView
        case .result(let users):
            StoryListItemsView(
                users: users,
                viewModel: viewModel
            )
        case .empty:
            errorView
        }
    }
    
    // MARK: - Loading View
    var loadingView: some View {
        ZStack(alignment: .center) {
            ProgressView("Loading stories...")
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1)
        }
    }
    
    // MARK: - Error View
    private var errorView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("Something went wrong")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal, 32)
            
            Button(action: {
                // handle retry action
            }) {
                Text("Try Again")
                    .padding(.horizontal, 36)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(Color.blue)
                    )
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.top, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Story List Items View
private struct StoryListItemsView: View {
    private let users: [DTO.Stories.Response.User]
    @State private var viewModel: StoriesListViewModelImpl
    @EnvironmentObject private var router: NavigationRouter
    
    init(users: [DTO.Stories.Response.User], viewModel: StoriesListViewModelImpl) {
        self.users = users
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(users) { user in
                        StoryItemView(
                            user: user,
                            viewModel: viewModel
                        )
                        .onTapGesture {
                            viewModel.makeStoryAsSeen(id: user.id)
                            router.presentFullScreen(.storyView(user: user))
                        }
                        .onAppear {
                            Task {
                                await viewModel.checkAndLoadMoreStories(user: user)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 120)
            .padding(.top, 12)
            
            Spacer()
        }
    }
}

// MARK: - Story Item View
private struct StoryItemView: View {
    @State private var viewModel: StoriesListViewModelImpl
    let user: DTO.Stories.Response.User
    
    init(user: DTO.Stories.Response.User, viewModel: StoriesListViewModelImpl) {
        self.user = user
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.blue
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(
                        viewModel.checkStorySeen(id: user.id) ? Color.black : Color.blue,
                        lineWidth: 2
                    )
            )
            
            Text(user.name)
                .font(.caption)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
        .frame(width: 120)
    }
}

#Preview {
    StoriesListView()
}
