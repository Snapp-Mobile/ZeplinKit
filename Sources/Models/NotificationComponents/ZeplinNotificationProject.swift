//
//  ZeplinNotificationProject.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to projects in a workspace.
public struct ZeplinNotificationProject: Codable, CustomStringConvertible, Sendable {
    /// The name of the project
    public let name: String
    /// The platform of the project
    public let platform: String

    /// User-friendly representation of the project
    public var description: String {
        return "\(name) (\(platform))"
    }
}
