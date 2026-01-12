//
//  ZeplinNotificationComponent.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to components in a project.
public struct ZeplinNotificationComponent: Codable, CustomStringConvertible, Sendable {
    /// The name of the component
    public let name: String

    /// User-friendly representation of the component
    public var description: String {
        return name
    }
}
