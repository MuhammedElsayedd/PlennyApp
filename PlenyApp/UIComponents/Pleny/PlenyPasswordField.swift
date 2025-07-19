//
//  PlenyPasswordField.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import SwiftUI

struct PlenyPasswordField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    @Binding var isSecure: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color.darkGrey)

            HStack {
                if isSecure {
                    SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray.opacity(0.5)))
                } else {
                    TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray.opacity(0.5)))
                }

                Button {
                    isSecure.toggle()
                } label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(Color.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

#Preview {
    PlenyPasswordField(
        title: "Password",
        placeholder: "Enter your password",
        text: .constant(""),
        isSecure: .constant(true)
    )
    .padding()
}
