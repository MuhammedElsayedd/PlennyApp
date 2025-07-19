//
//  PostImageGridView.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

struct PostImageGridView: View {
    let images: [String]
    let onImageTap: ((String) -> Void)?
    private let spacing: CGFloat = 4
    private let cornerRadius: CGFloat = 12
    private let contentWidth: CGFloat = UIScreen.main.bounds.width - 32

    var body: some View {
        switch images.count {
        case 1: singleImage(images[0])
        case 2: twoImages(images)
        case 3: threeImages(images)
        default: fallbackGrid(images)
        }
    }

    private func singleImage(_ image: String) -> some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: (contentWidth - spacing), height: 200)
            .clipped()
            .cornerRadius(cornerRadius)
            .onTapGesture {
                onImageTap?(image)
            }
    }

    private func twoImages(_ images: [String]) -> some View {
        HStack(spacing: spacing) {
            ForEach(images, id: \.self) { img in
                Image(img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (contentWidth - spacing) / 2, height: 200)
                    .clipped()
                    .cornerRadius(cornerRadius)
                    .onTapGesture {
                        onImageTap?(img)
                    }
            }
        }
    }

    private func threeImages(_ images: [String]) -> some View {
        HStack(spacing: spacing) {
            Image(images[0])
                .resizable()
                .scaledToFill()
                .frame(width: (contentWidth - spacing) * 0.6, height: 240)
                .clipped()
                .cornerRadius(cornerRadius)
                .onTapGesture {
                    onImageTap?(images[0])
                }

            VStack(spacing: spacing) {
                ForEach(images.dropFirst(), id: \.self) { img in
                    Image(img)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 116)
                        .clipped()
                        .cornerRadius(cornerRadius)
                        .onTapGesture {
                            onImageTap?(img)
                        }
                }
            }
            .frame(width: (contentWidth - spacing) * 0.4)
        }
    }

    private func fallbackGrid(_ images: [String]) -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: spacing) {
            ForEach(images, id: \.self) { img in
                Image(img)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()
                    .cornerRadius(cornerRadius)
                    .onTapGesture {
                        onImageTap?(img)
                    }
            }
        }
    }
}

#Preview("One Image") {
    PostImageGridView(
        images: ["img1"],
        onImageTap: { image in
            print("Tapped image: \(image)")
        }
    )
    .padding()
}

#Preview("Two Images") {
    PostImageGridView(
        images: ["img1", "img2"],
        onImageTap: { image in
            print("Tapped image: \(image)")
        }
    )
    .padding()
}

#Preview("Three Images") {
    PostImageGridView(
        images: ["img1", "img2", "img3"],
        onImageTap: { image in
            print("Tapped image: \(image)")
        }
    )
    .padding()
}
