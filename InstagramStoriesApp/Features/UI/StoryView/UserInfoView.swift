//
//  UserInfoView.swift
//  InstagramStoriesApp
//
//  Created by Usman on 26.07.25.
//

import SwiftUI

struct UserInfoView: View {
    let user: UI.Stories.User
    private let onCloseButtonTap: () -> Void
    
    init(
        user: UI.Stories.User,
        onCloseButtonTap: @escaping () -> Void
    ) {
        self.user = user
        self.onCloseButtonTap = onCloseButtonTap
    }
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: user.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            Text(user.name)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: onCloseButtonTap) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(8)
            }
        }
    }
}


