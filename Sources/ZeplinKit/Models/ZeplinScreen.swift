//
//  ZeplinScreen.swift
//  
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a screen on Zeplin
public struct ZeplinScreen: Decodable, Hashable, Identifiable, Equatable, Sendable {
    /// The unique id of the screen
    public let id: String
    /// The name of the screen
    public let name: String?
    /// The description of the screen
    public let description: String?
    /// The unix timestamp when the screen was created
    public let created: Double
    /// The unix timestamp when the screen was updated
    public let updated: Double?
    /// The image representing the screen
    public let image: ZeplinImage?
    /// The background color of the screen
    public let backgroundColor: ZeplinColor?
    /// Reference of the section that contains the screen
    public let section: ZeplinSection?
    /// The tags platform of the screen
    public let tags: [String]
    /// The number of notes in the screen
    public let numberOfNotes: Int?
    /// The number of versions exported to the screen
    public let numberOfVersions: Int?

    enum CodingKeys: String, CodingKey {
        case numberOfNotes = "number_of_notes"
        case numberOfVersions = "number_of_versions"
        case backgroundColor = "background_color"

        case id, name, description, image, section, created, updated, tags
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public func matches(term: String) -> Bool {
        let searchTerm = term.lowercased()
        let screenName = name ?? "untitled"
        return screenName.lowercased().contains(searchTerm) || tags.contains(where: { $0.lowercased().contains(searchTerm) })
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
