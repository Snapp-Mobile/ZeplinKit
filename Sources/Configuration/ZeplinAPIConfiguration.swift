//
//  ZeplinAPIConfiguration.swift
//  
//
//  Created by Ilian Konchev on 24.03.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A configuration object that is used for querying the Zeplin API
public protocol ZeplinAPIConfiguration: Sendable {
    /// Default size for paginating the results
    var pageSize: Int { get }
    var clientId: String { get }
    var clientSecret: String { get }
    var redirectURI: String { get }

    func encodedCredentials() -> String?
}
