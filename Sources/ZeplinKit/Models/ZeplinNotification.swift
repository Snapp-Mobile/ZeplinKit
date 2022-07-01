//
//  ZeplinNotification.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// A model representing a Zeplin notification
///
/// Notification objects have a polymorphic structure. They can be of various types and each type has a
/// certain set of actions that describe the notification further.
///
/// Notification content (specifically resource and context fields) varies based on the value of type field.
public struct ZeplinNotification: Codable, Hashable, Identifiable, Equatable, Sendable {
    /// The unique id of the notification
    public let id: String
    /// The unix timestamp when the notification was created
    public let created: Double
    /// The unix timestamp when the notification was updated
    public let updated: Double?
    /// Whether the notification is read or not
    public let isRead: Bool
    /// Type of the notification
    public let type: String
    /// Action that causes the notification
    public let action: ZeplinNotificationAction?
    /// The actor of the change triggering this notification
    public let actor: ZeplinNotificationActor
    /// The main object that this notification is related to. It contains the ID of the object along with its type
    /// and partial data. The content of this object varies between notification types.
    public let resource: ZeplinNotificationResource?
    /// Additional objects which are related to the main resource object.
    ///
    /// The content of this object changes depending on the type field (e.g. `{ project: { ... }, screen: { ... } }`
    /// for a screen related notification).
    public let context: ZeplinNotificationContext?

    enum CodingKeys: String, CodingKey {
        case id, action, type, created, updated, actor, resource, context
        case isRead = "is_read"
    }

    public init(id: String,
                created: Double,
                updated: Double?,
                isRead: Bool,
                type: String,
                action: ZeplinNotificationAction?,
                actor: ZeplinNotificationActor,
                resource: ZeplinNotificationResource?,
                context: ZeplinNotificationContext?) {
        self.id = id
        self.created = created
        self.updated = updated
        self.isRead = isRead
        self.type = type
        self.action = action
        self.actor = actor
        self.resource = resource
        self.context = context
    }

    /// User-friendly representation of the action that triggered the notification (e.g. _created a note "1"_)
    public var actionDescription: String {
        let resourceDescription = resource?.description ?? ""
        guard let actionDescription = action?.description else { return resourceDescription }
        return [actionDescription, resourceDescription].filter { !$0.isEmpty } .joined(separator: " ")
    }

    /// User-friendly representation of the context that the notification is triggered from (e.g. _Welcome screen -
    ///  MyFancyProject - iOS_)
    public var contextDescription: String {
        return context?.description ?? ""
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        let leftDate = lhs.updated ?? lhs.created
        let rightDate = rhs.updated ?? rhs.created
        return lhs.id == rhs.id && lhs.isRead == rhs.isRead && leftDate == rightDate
    }

    /// A flag that determines whether the notification has an attachment
    /// (an image to complement the presentation) or not
    public var hasAttachment: Bool {
        return (resource?.type == .version && resource?.extra as? ZeplinNotificationScreenVersion != nil) ||
            context?.version?.extra != nil
    }

    /// User-friendly representation of the screen version related to the notification, if available
    public var screenVersion: ZeplinNotificationScreenVersion? {
        if resource?.type == .version, let version = resource?.extra as? ZeplinNotificationScreenVersion {
            return version
        } else if let version = context?.version?.extra {
            return version
        } else {
            return nil
        }
    }

    /// Custom info that can be used for deep linking
    public var userInfo: ZeplinNotificationUserInfo {
        if let screen = context?.screen, let project = context?.project {
            return ZeplinNotificationUserInfo(screenId: screen.id, projectId: project.id)
        } else if case resource?.type = ZeplinNotificationResourceType.screen, let project = context?.project {
            return ZeplinNotificationUserInfo(screenId: resource?.id, projectId: project.id)
        } else if let project = context?.project {
            return ZeplinNotificationUserInfo(screenId: nil, projectId: project.id)
        } else if case resource?.type = ZeplinNotificationResourceType.project {
            return ZeplinNotificationUserInfo(screenId: nil, projectId: resource?.id)
        }
        return ZeplinNotificationUserInfo(screenId: nil, projectId: nil)
    }
}
