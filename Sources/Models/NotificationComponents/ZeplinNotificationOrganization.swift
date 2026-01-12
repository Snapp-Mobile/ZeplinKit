//
//  ZeplinNotificationOrganization.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to an organization.
public struct ZeplinNotificationOrganization: Codable, CustomStringConvertible, Sendable {
    /// The name of the organization
    public let name: String

    /// User-friendly representation of the organization
    public var description: String {
        return name
    }
}
