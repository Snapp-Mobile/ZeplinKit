//
//  ZeplinOrganizationSummary.swift
//
//
//  Created by Ilian Konchev on 12.02.21.
//  Copyright © 2021 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a summarized information about a Zeplin organization
public struct ZeplinOrganizationSummary: Decodable, Equatable, Sendable {
    /// Organization's unique id
    public let id: String
    /// Name of the user
    public let name: String
    /// URL of the organization's logo
    public let logo: String?
}
