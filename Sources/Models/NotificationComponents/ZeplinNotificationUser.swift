//
//  ZeplinNotificationUser.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data that is used for changes related to members of a styleguide.
public struct ZeplinNotificationUser: Codable, CustomStringConvertible, Sendable {
    /// The username of the user
    public let username: String

    /// User-friendly representation of the username
    public var description: String {
        return username
    }
}
