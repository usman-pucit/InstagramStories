//
//  StoryActionsButtonView.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import SwiftUI

struct StoryActionsButtonView: View {
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    @State private var isLiked: Bool = false
    @State private var isDisLiked: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 4) {
                // Like button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        updateLikeAStatus(isLiked: !isLiked)
                    }
                }) {
                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .font(.title2)
                        .foregroundColor(.white)
                        .scaleEffect(isLiked ? 1.2 : 1.0)
                }
            }
            
            VStack(spacing: 4) {
                // DisLike button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        updateLikeAStatus(isDisLiked: !isDisLiked)
                    }
                }) {
                    Image(systemName: isDisLiked ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .font(.title2)
                        .foregroundColor(.white)
                        .scaleEffect(isDisLiked ? 1.2 : 1.0)
                }
            }
        }
    }
    
    private func updateLikeAStatus(
        isLiked: Bool = false,
        isDisLiked: Bool = false
    ) {
        impactFeedback.impactOccurred()
        
        if isLiked {
            self.isLiked = true
            self.isDisLiked = false
        } else if isDisLiked {
            self.isDisLiked = true
            self.isLiked = false
        } else {
            self.isLiked = false
            self.isDisLiked = false
        }
    }
}
