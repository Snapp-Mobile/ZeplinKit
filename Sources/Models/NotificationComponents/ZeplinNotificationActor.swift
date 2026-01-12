//
//  ZeplinNotificationActor.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// A model representing the actor of the change that triggered the notification
public struct ZeplinNotificationActor: Codable, Sendable {
    /// The zeplin user that is making the change that triggered the notification
    public let user: ZeplinUser?
}
