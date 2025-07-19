//
//  LoginView.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 18/07/2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            headerImage
            
            VStack(spacing: 24) {
                welcomeText
                usernameField
                passwordField
                errorLabel
                signInButton
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var headerImage: some View {
        Image("loginIntroImage")
            .resizable()
            .scaledToFill()
            .frame(height: UIScreen.main.bounds.height * 0.5)
            .ignoresSafeArea(edges: .top)
    }
    
    private var welcomeText: some View {
        Text("Welcome")
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(Color.purple)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var usernameField: some View {
        PlenyTextField(
            title: "User Name",
            placeholder: "Enter your user name",
            text: $viewModel.username
        )
    }
    
    private var passwordField: some View {
        PlenyPasswordField(
            title: "Password",
            placeholder: "Enter your password",
            text: $viewModel.password,
            isSecure: $viewModel.isPasswordHidden
        )
    }
    
    private var errorLabel: some View {
        Group {
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private var signInButton: some View {
        PlenyPrimaryButton(title: "Sign in", isLoading: viewModel.isLoading) {
            viewModel.login()
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
