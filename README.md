<div align="center">
  <img src="Sources/ZeplinKit.docc/Resources/ZeplinKit-logo.png" width="200" alt="ZeplinKit Logo">
</div>

# ZeplinKit

Swift client library for the public Zeplin API

[![Latest Release](https://img.shields.io/github/v/release/oleksiikolomiietssnapp/MediaBridge?color=8B5CF6&logo=github&logoColor=white)](https://github.com/oleksiikolomiietssnapp/MediaBridge/releases)
[![Tests](https://github.com/oleksiikolomiietssnapp/MediaBridge/actions/workflows/test.yml/badge.svg)](https://github.com/oleksiikolomiietssnapp/MediaBridge/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-22C55E)](LICENSE)

## Overview

ZeplinKit provides data models and preconfigured API endpoints for the [Zeplin API](https://docs.zeplin.dev/docs/getting-started-with-zeplin-api). It offers a flexible client that integrates with any workflow, supporting both Combine publishers and Swift Concurrency (iOS 13+/macOS 11+).

The library includes `Fetcher`, a lightweight network client, and `ZeplinAPIURL`, an enumeration of API endpoints that encapsulates the required parameters for each call.

### Installation

```swift
// Swift Package Manager
.package(url: "https://github.com/Snapp-Mobile/ZeplinKit.git", from: "0.1.0")
```

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
