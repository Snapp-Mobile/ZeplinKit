# ``ZeplinKit``

@Metadata {
    @PageImage(purpose: icon, source:"ZeplinKit-logo")
}

Swift client library for the public Zeplin API.

## Overview

ZeplinKit is a collection of data models and preconfigured API URLs to consume the public Zeplin API. Adding ZeplinKit to your app gives you a flexible client for consuming the Zeplin API that fits in any workflow.

Zeplin kit utilizes `Fetcher` - a tiny network client for fetching data off the web. The client exposes both a `Combine` publisher for the desired Zeplin endpoints and a Swift Concurrency interface (where available).

The core of the ZeplinKit library is ``ZeplinKit/ZeplinAPIURL`` - an enumeration of the Zeplin API endpoints which
encapsulates the parameters needed to do the API calls. The enum values should be passed to the `Fetcher` client after 
populating the associated values where needed.

For example, if you want to fetch the first 10 projects for your account, you would do something like this:

```swift
import ZeplinKit

let fetcher = Fetcher(
    environment: .production,
    accessToken: "your_zeplin_access_token"
)

let url = ZeplinAPIURL.getProjects(10, 0)

do {
    let projects: [ZeplinProject] = try await fetcher.fetch(url)
    // Handle projects
} catch {
    print("Failed to fetch projects: \(error.localizedDescription)")
}
```

## Topics

### API

- ``ZeplinAPIURL``
