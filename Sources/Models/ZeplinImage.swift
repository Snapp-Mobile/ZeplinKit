//
//  ZeplinImage.swift
//  
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a Zeplin image
public struct ZeplinImage: Decodable, Hashable, Equatable, Sendable {
    /// Width of the component image
    public let width: Double
    /// Height of the component image
    public let height: Double
    /// URL of the original image for the component (from the latest version)
    public let originalURL: String

    enum CodingKeys: String, CodingKey {
        case width, height
        case originalURL = "original_url"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(originalURL)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.originalURL == rhs.originalURL
    }
}
