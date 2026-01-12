<div align="center">
  <img src="Sources/ZeplinKit.docc/Resources/ZeplinKit-logo.png" width="200" alt="ZeplinKit Logo">
</div>

# ZeplinKit

Swift client library for the public Zeplin API

[![Swift Package Index](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FSnapp-Mobile%2FZeplinKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Snapp-Mobile/ZeplinKit)
[![iOS 13.0+](https://img.shields.io/badge/iOS-13.0+-007AFF?logo=apple&logoColor=white)](https://www.apple.com/ios/)
[![Latest Release](https://img.shields.io/github/v/release/Snapp-Mobile/ZeplinKit?color=8B5CF6&logo=github&logoColor=white)](https://github.com/Snapp-Mobile/ZeplinKit/releases)
[![Tests](https://github.com/Snapp-Mobile/ZeplinKit/actions/workflows/test.yml/badge.svg)](https://github.com/Snapp-Mobile/ZeplinKit/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-22C55E)](LICENSE)

## Overview

ZeplinKit provides data models and preconfigured API endpoints for the [Zeplin API](https://docs.zeplin.dev/docs/getting-started-with-zeplin-api). It offers a flexible client that integrates with any workflow, supporting both Combine publishers and Swift Concurrency (iOS 13+/macOS 11+).

The library includes `Fetcher`, a lightweight network client, and `ZeplinAPIURL`, an enumeration of API endpoints that encapsulates the required parameters for each call.

### Installation

```swift
// Swift Package Manager
.package(url: "https://github.com/Snapp-Mobile/ZeplinKit.git", from: "0.1.0")
```

### Authentication

To use ZeplinKit, you'll need a Zeplin access token. Learn how to generate one in the [Zeplin API documentation](https://blog.zeplin.io/collaboration/getting-started-with-zeplin-javascript-sdk/).

### Setup

```swift
import ZeplinKit

let fetcher = Fetcher(
    environment: .production,
    accessToken: "your_zeplin_access_token"
)
```

### Usage

To fetch the first 10 projects for your account:

```swift
func loadProjects() async {
    let url = ZeplinAPIURL.getProjects(10, 0)
    
    do {
        let projects: [ZeplinProject] = try await fetcher.fetch(url)
        // Handle projects
    } catch {
        print("Failed to fetch projects: \(error.localizedDescription)")
    }
}
```
