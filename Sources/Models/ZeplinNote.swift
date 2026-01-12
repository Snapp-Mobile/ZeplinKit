//
//  ZeplinNote.swift
//
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import UIKit

/// A model that represents a note on Zeplin
public struct ZeplinNote: Decodable, Hashable, Equatable, Sendable {

    public enum Status: String, Decodable, Sendable {
        case open
        case resolved
    }

    /// The unique id of the note
    public let id: String
    /// Order of the note in the screen (e.g., 1, 2, 3, so on)
    public let order: String
    /// Color of the note pin
    public let color: ZeplinColor
    /// Normalized position of the note on screen
    public let position: ZeplinNotePosition
    /// List of comments associated with the note
    public let comments: [ZeplinComment]
    /// Author of the note
    public let creator: ZeplinUser
    /// Status of the note ("open" or "resolved")
    public let status: Status
    /// The unix timestamp when the note was created
    public let created: Double

    public init(
        id: String,
        order: String,
        color: ZeplinColor,
        position: ZeplinNotePosition,
        comments: [ZeplinComment],
        creator: ZeplinUser,
        status: Status,
        created: Double
    ) {
        self.id = id
        self.order = order
        self.color = color
        self.position = position
        self.comments = comments
        self.creator = creator
        self.status = status
        self.created = created
    }

    /// `UIColor` representation of the note pin color
    public var pinColor: UIColor {
        guard let colorName = color.name, let zeplinColor = ZeplinNamedColor(rawValue: colorName) else {
            return UIColor(
                displayP3Red: CGFloat(color.red) / 255, green: CGFloat(color.green) / 255, blue: CGFloat(color.blue) / 255, alpha: 1.0)
        }
        return zeplinColor.color
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.order == rhs.order && lhs.status == rhs.status
    }

}
