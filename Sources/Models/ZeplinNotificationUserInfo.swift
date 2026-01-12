//
//  ZeplinNotificationUserInfo.swift
//
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// A model representing the user unfo that gets assigned with the deeplinks
public struct ZeplinNotificationUserInfo: Sendable {
    /// The id of the screen that is referred in the notification
    public let screenId: String?
    /// The id of the project that is referred in the notification
    public let projectId: String?
}
