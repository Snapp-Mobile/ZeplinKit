//
//  ZeplinNotificationAction.swift
//
//
//  Created by Ilian Konchev on 29.01.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// An enumeration representing the actions a notification can be reated to.
///
/// The actions vary depending on the notification type and resource, see ``ZeplinKit/ZeplinNotificationResource``
public enum ZeplinNotificationAction: String, CustomStringConvertible, Codable, Sendable {
    case activated
    case added
    case archived
    case created
    case deleted
    case invited
    case joined
    case mentioned
    case ownershipTransferred
    case removed
    case resolved
    case updatedRole = "role_updated"
    case updated
    case versionCreated = "version_created"

    case unknown

    public init(from decoder: Decoder) throws {
        guard let rawValue = try? decoder.singleValueContainer().decode(String.self) else {
            self = .unknown
            return
        }
        self = ZeplinNotificationAction(rawValue: rawValue) ?? .unknown
    }

    /// User-friendly representation of the action
    public var description: String {
        switch self {
        case .ownershipTransferred:
            return "transferred ownership"
        case .updatedRole:
            return "updated role"
        case .versionCreated:
            return "created version for"
        case .unknown:
            return ""
        default:
            return rawValue
        }
    }
}
