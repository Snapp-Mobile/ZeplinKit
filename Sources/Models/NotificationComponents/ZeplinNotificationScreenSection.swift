//
//  ZeplinNotificationScreenSection.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to jira attachments in a screen section.
public struct ZeplinNotificationScreenSection: Codable, CustomStringConvertible, Sendable {
    /// The name of the screen section
    public let name: String

    /// User-friendly representation of the section
    public var description: String {
        return name
    }
}
