//
//  ZeplinNotificationScreen.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to screens in a project.
public struct ZeplinNotificationScreen: Codable, CustomStringConvertible, Sendable {
    /// The name of the screen
    public let name: String

    /// User-friendly representation of the screen
    public var description: String {
        return name
    }
}
