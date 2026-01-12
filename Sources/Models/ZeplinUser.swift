//
//  ZeplinUser.swift
//
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents basic info about users on Zeplin
///
/// Zeplin API does not expose any personal information to third-party clients. For this reason, the email field is
/// a Zeplin-only alias by default.
///
/// You can get the original email addresses of members of your workspace by using a personal access token created with admin rights.
///
/// Third-party (OAuth) applications are not allowed to access this information.
///
/// _Only organization admins (or higher) can retrieve the original email addresses using an admin token._
public struct ZeplinUser: Codable, Equatable, Sendable {
    /// User's unique id
    public let id: String
    /// Zeplin-only alias for the user's email (original)
    public let email: String
    /// Username of the user
    public let username: String?
    /// Emotar of the user
    public let emotar: String?
    /// Avatar of the user
    public let avatarURL: String?
    /// The unix timestamp when the user was last seen
    public let lastSeen: Double?

    enum CodingKeys: String, CodingKey {
        case id, email, username, emotar
        case lastSeen = "last_seen"
        case avatarURL = "avatar"
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
            && lhs.email == rhs.email
            && lhs.username == rhs.username
            && lhs.emotar == rhs.emotar
            && lhs.avatarURL == rhs.avatarURL
    }
}
