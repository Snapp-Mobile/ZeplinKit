//
//  ZeplinNotificationScreenNoteComment.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to note comments.
public struct ZeplinNotificationScreenNoteComment: Codable, CustomStringConvertible, Sendable {
    /// The content of the comment
    public let content: String

    /// User-friendly representation of the note content
    public var description: String {
        return content
    }
}
