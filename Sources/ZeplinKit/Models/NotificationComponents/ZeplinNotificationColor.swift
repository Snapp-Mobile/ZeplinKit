//
//  ZeplinNotificationColor.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to colors in a project.
public struct ZeplinNotificationColor: Codable, CustomStringConvertible, Sendable {
    /// The name of the color
    public let name: String
    /// The red component
    public let red: Int
    /// The green component
    public let green: Int
    /// The blue component
    public let blue: Int
    /// The alpha component
    public let alpha: Int

    enum CodingKeys: String, CodingKey {
        case name
        case red = "r"
        case green = "g"
        case blue = "b"
        case alpha = "a"
    }

    /// User-friendly representation of the color
    public var description: String {
        return name
    }
}
