//
//  ZeplinNotificationOrganizationMember.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to members of a workspace.
public struct ZeplinNotificationOrganizationMember: Codable, CustomStringConvertible, Sendable {
    /// The role of the member
    public let role: String

    /// User-friendly representation of the member
    public var description: String {
        return role
    }
}
