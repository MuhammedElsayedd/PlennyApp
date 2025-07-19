//
//  PlenyTextField.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

struct PlenyTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color.darkGrey)
            
            TextField("", text: $text, prompt: Text(placeholder)
                .foregroundColor(.gray.opacity(0.5)))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

#Preview {
    PlenyTextField(
        title: "User Name",
        placeholder: "Enter your user name",
        text: .constant("")
    )
    .padding()
}
