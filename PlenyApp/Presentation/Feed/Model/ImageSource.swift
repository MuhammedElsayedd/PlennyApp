//
//  ImageSource.swift
//  PlenyApp
//
//  Created by Muhammed Elsayed on 19/07/2025.
//

import Foundation
enum ImageSource: Identifiable {
    case profile(String)
    case post(String)

    var id: String {
        switch self {
        case .profile(let name), .post(let name):
            return name
        }
    }

    var name: String {
        switch self {
        case .profile(let name), .post(let name):
            return name
        }
    }
}
