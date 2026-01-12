//
//  ZeplinScreenVersionSummary.swift
//
//
//  Created by Ilian Konchev on 27.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a screen version on Zeplin
public struct ZeplinScreenVersionSummary: Decodable, Hashable, Identifiable, Equatable, Sendable {
    /// The unique id of the version
    public let id: String
    /// Author of the version
    public let creator: ZeplinUser?
    /// The commit associated with the version
    public let commit: ZeplinScreenVersionCommit?
    /// URL of the image for the version
    public let imageURL: String
    /// Source application of the version
    public let source: String
    /// Width of the version
    public let width: Double
    /// Height of the version
    public let height: Double
    /// Pixel density
    public let density: Double
    /// The unix timestamp when the screen version was created
    public let created: Double
    /// Background color of the version
    public let backgroundColor: ZeplinColor?

    enum CodingKeys: String, CodingKey {
        case id, creator, source, width, height, created, commit
        case imageURL = "image_url"
        case density = "density_scale"
        case backgroundColor = "background_color"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
