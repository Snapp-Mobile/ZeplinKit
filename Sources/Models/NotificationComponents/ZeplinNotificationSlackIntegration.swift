//
//  ZeplinNotificationSlackIntegration.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to slack intgrations in a project.
public struct ZeplinNotificationSlackIntegration: Codable, CustomStringConvertible, Sendable {
    /// The name of the slack channel
    public let channel: String

    /// User-friendly representation of the channel
    public var description: String {
        return channel
    }
}
