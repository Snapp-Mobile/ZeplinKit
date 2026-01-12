//
//  ZeplinNotificationResourceType.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// An enumeration representing the supported notification resource types
public enum ZeplinNotificationResourceType: String, CustomStringConvertible, Decodable, Sendable {
    case color = "Color"
    case comment = "ScreenNoteComment"
    case component = "Component"
    case `extension` = "Extension"
    case jiraIntegration = "JiraIntegration"
    case note = "ScreenNote"
    case organizationMember = "OrganizationMember"
    case project = "Project"
    case screen = "Screen"
    case section = "ScreenSection"
    case slackIntegration = "SlackIntegration"
    case spacingToken = "SpacingToken"
    case styleguide = "Styleguide"
    case textStyle = "TextStyle"
    case user = "User"
    case version = "ScreenVersion"

    case unknown

    public init(from decoder: Decoder) throws {
        guard let rawValue = try? decoder.singleValueContainer().decode(String.self) else {
            self = .unknown
            return
        }
        self = ZeplinNotificationResourceType(rawValue: rawValue) ?? .unknown
    }

    /// User-friendly representation of the resource type
    public var description: String {
        switch self {
        case .comment:
            return "comment"
        case .jiraIntegration:
            return "JIRA integration"
        case .note:
            return "note"
        case .textStyle:
            return "text style"
        case .organizationMember:
            return "member"
        case .section:
            return "section"
        case .spacingToken:
            return "spacing"
        case .slackIntegration:
            return "Slack integration"
        case .version:
            return "version"
        case .unknown:
            return ""
        default:
            return rawValue.description.lowercased()
        }
    }
}
