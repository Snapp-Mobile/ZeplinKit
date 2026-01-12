//
//  ZeplinComment.swift
//  
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a Zeplin comment
public struct ZeplinComment: Decodable, Hashable, Equatable, Sendable {
    /// Unique id of the comment
    public let id: String
    /// Author of the comment
    public let author: ZeplinUser
    /// Content of the comment
    public let content: String
    /// The unix timestamp when the comment was updated
    public let updated: Double

    /// Creating a comment
    /// - Parameters:
    ///   - id: Unique id of the comment
    ///   - author: Author of the comment
    ///   - content: Content of the comment
    ///   - updated: The unix timestamp when the comment was updated
    public init(id: String,
                author: ZeplinUser,
                content: String,
                updated: Double) {
        self.id = id
        self.author = author
        self.content = content
        self.updated = updated
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.content == rhs.content && lhs.updated == rhs.updated
    }
}
