//
//  StoryViewScreen.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import SwiftUI

struct StoryViewScreen: View {
    @EnvironmentObject private var router: NavigationRouter
    @State private var isLiked: Bool = false
    @State private var isDisliked: Bool = false
    private let user: DTO.Stories.Response.User
    
    init(user: DTO.Stories.Response.User) {
        self.user = user
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                AsyncImage(url: URL(string: user.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                
                // Gradient overlay
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.3),
                        Color.clear,
                        Color.black.opacity(0.3),
                        Color.black.opacity(0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                VStack {
                    UserInfoView(user: user) {
                        router.dismissFullScreen()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        StoryActionsButtonView()
                            .padding(.trailing, 16)
                            .padding(.bottom, 30)

                    }
                }
            }
        }
    }
}

#Preview {
    StoryViewScreen(user: DTO.Stories.Response.User(id: 1, name: "User 1", imageUrl: "https://i.pravatar.cc/300?u=10"))
}
