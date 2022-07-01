//
//  MockZeplinAPIConfiguration.swift
//  
//
//  Created by Ilian Konchev on 9.02.22.
//

import ZeplinKit

struct MockZeplinAPIConfiguration: ZeplinAPIConfiguration {
    /// Default size for paginating the results
    let pageSize: Int = 100
    let clientId = "abc123"
    let clientSecret = "123abc"
    let redirectURI = "snappzeplin://auth_response"

    func encodedCredentials() -> String? {
        let credentials = "\(clientId):\(clientSecret)".data(using: .utf8)
        return credentials?.base64EncodedString()
    }
}
