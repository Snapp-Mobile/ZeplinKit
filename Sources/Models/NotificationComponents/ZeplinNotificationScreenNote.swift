//
//  ZeplinNotificationScreenNote.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to notes.
public struct ZeplinNotificationScreenNote: Codable, CustomStringConvertible, Sendable {
    /// The order of the note
    public let order: String
    /// The color of the not pin
    public let color: ZeplinColor
    /// The status of the note
    public let status: String

    /// User-friendly representation of the note
    public var description: String {
        return order
    }
}
