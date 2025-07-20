# PlenyApp

An iOS SwiftUI app for browsing and searching social posts, built as part of a technical assessment for the iOS Software Engineer position at Pleny.

## Overview

PlenyApp allows users to:

- Log in using the DummyJSON authentication API.
- View paginated social posts with infinite scroll.
- Search for posts.
- View static profile and post images.
- Tap to preview profile or post images fullscreen.
- Navigate between views using the Coordinator pattern.
- Handle offline loading via Core Data caching.
- Maintain a clean, testable codebase using modern architecture patterns.

## Tech Stack

- iOS 15+
- SwiftUI + Combine
- Clean Architecture (MVVM + Coordinator)
- Repository Pattern
- Core Data (for offline post caching)
- Unit Testing (Login and Feed use cases)

## Authentication

Implemented using the [DummyJSON Login API](https://dummyjson.com/docs/auth#login).  
Login is required before accessing any post data.

## Posts

Posts are retrieved from the [DummyJSON Posts API](https://dummyjson.com/docs/posts).  
The app supports:

- Infinite scrolling (pagination using `skip` and `limit`)
- Static image rendering for profile and post images (fetched from Figma assets)

## Core Data Caching

Core Data was implemented to store and retrieve posts when offline or when the API call fails.

- Posts are cached after successful API calls.
- Cached posts are loaded on failure or app restart.

## Unit Testing

Unit tests were written using XCTest and Combine for:

- **LoginUseCase**
- **FeedUseCase** (Fetching Posts)

Mock repositories were used to simulate success and failure responses.
