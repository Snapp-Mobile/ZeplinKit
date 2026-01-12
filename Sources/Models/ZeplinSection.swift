//
//  ZeplinSection.swift
//
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a section on Zeplin
///
/// Sections are used within the projects to organize screens
public struct ZeplinSection: Decodable, Hashable, Identifiable, Equatable, Sendable {
    /// The unique id of the screen section
    public let id: String
    /// The name of the screen section
    public let name: String?
    /// The description of the screen section
    public let description: String?
    /// The unix timestamp when the screen section was created
    public let created: Double?
    /// The array of ids of the screens in the section
    public var screens: [String] = []

    /// Create a `ZeplinSection` instance
    /// - Parameters:
    ///   - id: The unique id of the screen section
    ///   - name: The name of the screen section
    ///   - description: The description of the screen section
    ///   - created: The unix timestamp when the screen section was created
    ///   - screens: The array of ids of the screens in the section
    public init(id: String, name: String? = nil, description: String? = nil, created: Double? = nil, screens: [String] = []) {
        self.id = id
        self.name = name
        self.description = description
        self.created = created ?? Date().timeIntervalSince1970
        self.screens = screens
    }

    enum CodingKeys: String, CodingKey {
        case id, name, description, created
    }

    /// Formatted representation of the section name
    public var formattedName: String {
        return name ?? "Untitled \(id)"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
