//
//  ZeplinNotificationExtension.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to extensions in a project.
public struct ZeplinNotificationExtension: Codable, CustomStringConvertible, Sendable {
    /// The name of the extension
    public let name: String

    /// User-friendly representation of the extension
    public var description: String {
        return name
    }
}
