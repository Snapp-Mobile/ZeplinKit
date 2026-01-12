//
//  ZeplinNotificationResource.swift
//
//
//  Created by Ilian Konchev on 29.01.21.
//  Copyright © 2021 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model representint the main object that the notification is related to.
///
/// It contains the ID of the object along with its type and partial data. The content of this object varies between notification types.
public struct ZeplinNotificationResource: Codable, CustomStringConvertible, Sendable {
    /// The unique id of the resource
    public let id: String
    /// Type of the object, which is one of the API models
    public let type: ZeplinNotificationResourceType
    /// Partial data of the resource, whose content changes depending on the type field
    public let extra: (Codable & Sendable)?

    enum CodingKeys: String, CodingKey {
        case id, type, extra
    }

    // swiftlint:disable cyclomatic_complexity
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type.rawValue, forKey: .type)
        switch type {
        case .color:
            try container.encodeIfPresent(extra as? ZeplinNotificationColor, forKey: .extra)
        case .comment:
            try container.encodeIfPresent(extra as? ZeplinNotificationScreenNoteComment, forKey: .extra)
        case .component:
            try container.encodeIfPresent(extra as? ZeplinNotificationComponent, forKey: .extra)
        case .extension:
            try container.encodeIfPresent(extra as? ZeplinNotificationExtension, forKey: .extra)
        case .jiraIntegration:
            try container.encodeIfPresent(extra as? ZeplinNotificationJiraIntegration, forKey: .extra)
        case .note:
            try container.encodeIfPresent(extra as? ZeplinNotificationScreenNote, forKey: .extra)
        case .organizationMember:
            try container.encodeIfPresent(extra as? ZeplinNotificationOrganizationMember, forKey: .extra)
        case .project:
            try container.encodeIfPresent(extra as? ZeplinNotificationProject, forKey: .extra)
        case .screen:
            try container.encodeIfPresent(extra as? ZeplinNotificationScreen, forKey: .extra)
        case .section:
            try container.encodeIfPresent(extra as? ZeplinNotificationScreenSection, forKey: .extra)
        case .slackIntegration:
            try container.encodeIfPresent(extra as? ZeplinNotificationSlackIntegration, forKey: .extra)
        case .spacingToken:
            try container.encodeIfPresent(extra as? ZeplinNotificationSpacingToken, forKey: .extra)
        case .styleguide:
            try container.encodeIfPresent(extra as? ZeplinNotificationStyleguide, forKey: .extra)
        case .textStyle:
            try container.encodeIfPresent(extra as? ZeplinNotificationTextStyle, forKey: .extra)
        case .user:
            try container.encodeIfPresent(extra as? ZeplinNotificationUser, forKey: .extra)
        case .version:
            try container.encodeIfPresent(extra as? ZeplinNotificationScreenVersion, forKey: .extra)
        case .unknown:
            break
        }
    }

    // swiftlint:disable cyclomatic_complexity
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        type = try values.decode(ZeplinNotificationResourceType.self, forKey: .type)

        switch type {
        case .color:
            extra = try? values.decode(ZeplinNotificationColor.self, forKey: .extra)
        case .comment:
            extra = try? values.decode(ZeplinNotificationScreenNoteComment.self, forKey: .extra)
        case .component:
            extra = try? values.decode(ZeplinNotificationComponent.self, forKey: .extra)
        case .extension:
            extra = try? values.decode(ZeplinNotificationExtension.self, forKey: .extra)
        case .jiraIntegration:
            extra = try? values.decode(ZeplinNotificationJiraIntegration.self, forKey: .extra)
        case .note:
            extra = try? values.decode(ZeplinNotificationScreenNote.self, forKey: .extra)
        case .organizationMember:
            extra = try? values.decode(ZeplinNotificationOrganizationMember.self, forKey: .extra)
        case .project:
            extra = try? values.decode(ZeplinNotificationProject.self, forKey: .extra)
        case .screen:
            extra = try? values.decode(ZeplinNotificationScreen.self, forKey: .extra)
        case .section:
            extra = try? values.decode(ZeplinNotificationScreenSection.self, forKey: .extra)
        case .slackIntegration:
            extra = try? values.decode(ZeplinNotificationSlackIntegration.self, forKey: .extra)
        case .spacingToken:
            extra = try? values.decode(ZeplinNotificationSpacingToken.self, forKey: .extra)
        case .styleguide:
            extra = try? values.decode(ZeplinNotificationStyleguide.self, forKey: .extra)
        case .textStyle:
            extra = try? values.decode(ZeplinNotificationTextStyle.self, forKey: .extra)
        case .user:
            extra = try? values.decode(ZeplinNotificationUser.self, forKey: .extra)
        case .version:
            extra = try? values.decode(ZeplinNotificationScreenVersion.self, forKey: .extra)
        case .unknown:
            extra = nil
        }
    }

    public var name: String {
        switch type {
        case .color:
            guard let color = extra as? ZeplinNotificationColor else { return "" }
            return color.description
        case .comment:
            guard let noteComment = extra as? ZeplinNotificationScreenNoteComment else { return "" }
            return noteComment.description
        case .component:
            guard let component = extra as? ZeplinNotificationComponent else { return "" }
            return component.description
        case .extension:
            guard let ext = extra as? ZeplinNotificationExtension else { return "" }
            return ext.description
        case .jiraIntegration:
            guard let integration = extra as? ZeplinNotificationJiraIntegration else { return "" }
            return integration.description
        case .note:
            guard let screenNote = extra as? ZeplinNotificationScreenNote else { return "" }
            return screenNote.description
        case .organizationMember:
            guard let member = extra as? ZeplinNotificationOrganizationMember else { return "" }
            return member.description
        case .project:
            guard let project = extra as? ZeplinNotificationProject else { return "" }
            return project.description
        case .screen:
            guard let screen = extra as? ZeplinNotificationScreen else { return "" }
            return screen.description
        case .section:
            guard let section = extra as? ZeplinNotificationScreenSection else { return "" }
            return section.description
        case .slackIntegration:
            guard let ext = extra as? ZeplinNotificationExtension else { return "" }
            return ext.description
        case .spacingToken:
            guard let integraion = extra as? ZeplinNotificationSlackIntegration else { return "" }
            return integraion.description
        case .styleguide:
            guard let styleguide = extra as? ZeplinNotificationStyleguide else { return "" }
            return styleguide.description
        case .textStyle:
            guard let style = extra as? ZeplinNotificationTextStyle else { return "" }
            return style.description
        case .user:
            guard let user = extra as? ZeplinNotificationUser else { return "" }
            return user.description
        case .version:
            guard let version = extra as? ZeplinNotificationScreenVersion else { return "" }
            return version.description
        case .unknown:
            return ""
        }
    }

    public var description: String {
        return "\(type.description) \"\(name)\""
    }
}
