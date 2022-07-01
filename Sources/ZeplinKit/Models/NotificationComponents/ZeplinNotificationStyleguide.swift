//
//  ZeplinNotificationStyleguide.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to styleguides in a workspace.
public struct ZeplinNotificationStyleguide: Codable, CustomStringConvertible, Sendable {
    /// The name of the styleguide
    public let name: String
    /// The platform of the styleguide
    public let platform: String

    /// User-friendly representation of the styleguide
    public var description: String {
        return "\(name) (\(platform))"
    }
}
