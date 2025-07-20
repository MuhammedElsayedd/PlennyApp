//
//  PostCardView.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

struct PostCardView: View {
    let post: PostUIModel
    var onProfileTap: (() -> Void)?
    var onImageTap: ((String) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(post.userImage ?? "defaultUser")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .onTapGesture {
                        if let imageName = post.userImage {
                            onImageTap?(imageName)
                        }
                        onProfileTap?()
                    }
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.username ?? "Unknown User")
                        .font(.subheadline)
                        .fontWeight(.bold)

                    Text(post.timeAgo ?? "Just now")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            if let body = post.body {
                Text(body)
                    .font(.body)
            }

            if let images = post.postImages, !images.isEmpty {
                PostImageGridView(images: images, onImageTap: onImageTap)
            }
        }
        .padding()
    }
}

#Preview {
    let dummyPost = Post(
        id: 1,
        body: "Craving something delicious? Try our new dish - a savory mix of roasted vegetables and quinoa, topped with a zesty garlic. Yum!",
        title: "Delicious Dish",
        userId: 1,
        image: nil
    )

    return PostCardView(post: PostUIModel(from: dummyPost))
}
