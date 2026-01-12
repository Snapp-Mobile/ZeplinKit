//
//  ZeplinNotificationSpacingToken.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to styleguides in a workspace.
public struct ZeplinNotificationSpacingToken: Codable, CustomStringConvertible, Sendable {
    /// The name of the spacing token
    public let name: String
    /// The value of the spacing token
    public let value: String

    /// User-friendly representation of the spacing token
    public var description: String {
        return name
    }
}
