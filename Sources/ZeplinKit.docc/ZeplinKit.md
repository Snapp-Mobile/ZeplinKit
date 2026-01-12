# ``ZeplinKit``

@Metadata {
    @PageImage(purpose: icon, source:"ZeplinKit-logo")
}

Swift client library for the public Zeplin API.

## Overview

ZeplinKit is a collection of data models and preconfigured API URLs to consume the public Zeplin API. Adding ZeplinKit to your app gives you a flexible client for consuming the Zeplin API that fits in any workflow.

Zeplin kit utilizes `Fetcher` - a tiny network client for fetching data off the web. The client exposes both a `Combine` publisher for the desired Zeplin endpoints and a Swift Concurrency interface (where available).

The the core of the ZeplinKit library is ``ZeplinKit/ZeplinAPIURL`` - an enumeration of the Zeplin API endpoints which
encapsulates the parameters needed to do the API calls. The enum values should be passed to the `Fetcher` client after 
populating the associated values where needed.

For example, if you want to fetch the first 10 projects for your account, you would do something like this:

```swift
import ZeplinKit
// init the fetcher with an environment
let fetcher = Fetcher(environment: ...)
// prepare the APIURL
let url = ZeplinAPIURL.getProjects(10, 0)
do {
    // execute the request and get the list of projects
    let projects: [ZeplinProject] = try await fetcher.fetch(url)
    // do something with the projects
} catch let error {
    // handle any possible error
    print("Error:", error.localizedDescription)
}
```

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
