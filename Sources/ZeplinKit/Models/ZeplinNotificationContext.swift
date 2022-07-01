//
//  ZeplinNotificationContext.swift
//  
//
//  Created by Ilian Konchev on 29.01.21.
//  Copyright © 2021 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents additional objects which are related to the main resource object.
///
/// The content of this object changes depending on the type field (e.g. `{ project: { ... }, screen: { ... } }`
/// for a screen related notification).
public struct ZeplinNotificationContext: Codable, CustomStringConvertible, Sendable {
    /// The project that the notification resource is related to
    public let project: Wrapper<ZeplinNotificationProject>?
    /// The screen section that the notification resource is related to
    public let section: Wrapper<ZeplinNotificationScreenSection>?
    /// The screen that the notification resource is related to
    public let screen: Wrapper<ZeplinNotificationScreen>?
    /// The note that the notification resource is related to
    public let screenNote: Wrapper<ZeplinNotificationScreenNote>?
    /// The styleguide that the notification resource is related to
    public let styleguide: Wrapper<ZeplinNotificationStyleguide>?
    /// The organization that the notification resource is related to
    public let organization: Wrapper<ZeplinNotificationOrganization>?
    /// The note comment that the notification resource is related to
    public let noteComment: Wrapper<ZeplinNotificationScreenNoteComment>?
    /// The screen version that the notification resource is related to
    public let version: Wrapper<ZeplinNotificationScreenVersion>?

    enum CodingKeys: String, CodingKey {
        case project, screen, styleguide, version, organization, section
        case screenNote = "note"
        case noteComment = "comment"
    }

    /// User-friendly representation of the components in the context
    public var description: String {
        let components: [String?] = [
            noteComment?.description,
            screenNote?.description,
            screen?.description,
            section?.description,
            styleguide?.description,
            project?.description,
            organization?.description
        ]

        return components.compactMap { $0 }.joined(separator: " ◦ ")
    }
}
