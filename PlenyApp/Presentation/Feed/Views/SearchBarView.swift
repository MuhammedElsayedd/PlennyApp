//
//  SearchBarView.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String = "Search..."
    
    var onClear: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Image("searchIcon")
            
            TextField(placeholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .autocapitalization(.none)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onClear?()
                }) {
                    Image("clearSearchIcon")
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        )
    }
}

private struct SearchBarPreviewWrapper: View {
    @State private var text = "food"

    var body: some View {
        SearchBarView(text: $text)
            .padding()
    }
}

#Preview {
    SearchBarPreviewWrapper()
}
