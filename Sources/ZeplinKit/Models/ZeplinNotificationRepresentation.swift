//
//  ZeplinNotificationRepresentation.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// A model that wraps a tiny representation of the notification for using in the UI
public struct ZeplinNotificationRepresentation: Hashable, Identifiable, Equatable, Sendable {
    /// The id of the notification
    public let id: String
    /// The creation date
    public var created: Double
    /// The date of the last update
    public var lastUpdated: Double
    /// A flag to determine if the notification has been read or not
    public var isRead: Bool

    public init(id: String, created: Double, lastUpdated: Double, isRead: Bool) {
        self.id = id
        self.created = created
        self.lastUpdated = lastUpdated
        self.isRead = isRead
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
        && lhs.created == rhs.created
        && lhs.lastUpdated == rhs.lastUpdated
        && lhs.isRead == rhs.isRead
    }
}
