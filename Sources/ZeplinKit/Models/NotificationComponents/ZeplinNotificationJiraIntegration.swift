//
//  ZeplinNotificationJiraIntegration.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to jira integration.
public struct ZeplinNotificationJiraIntegration: Codable, CustomStringConvertible, Sendable {
    /// The JIRA issue identifier
    public let issue: String

    /// User-friendly representation of the jira issue
    public var description: String {
        return "#\(issue)"
    }
}
