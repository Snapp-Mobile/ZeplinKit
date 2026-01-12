//
//  ZeplinProject.swift
//
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import CoreSpotlight
import Foundation
import MobileCoreServices

public enum ZeplinPlatform: String, Decodable, CustomStringConvertible, Sendable {
    case web, ios, android, macos

    public var description: String {
        switch self {
        case .web:
            return "Web"
        case .ios:
            return "iOS"
        case .android:
            return "Android"
        case .macos:
            return "MacOS"
        }
    }
}

/// A model that represents a reference to a styleguide
public struct LinkedStyleguide: Decodable, Sendable {
    /// Id of the entity
    public let id: String
}

/// A model that represents a project on Zeplin
public struct ZeplinProject: Decodable, Hashable, Identifiable, Equatable, Sendable {
    /// The unique id of the project
    public let id: String
    /// The name of the project
    public let name: String
    /// The description of the project
    public let description: String?
    /// URL of the project's thumbnail image
    public let thumbnailURL: String?
    /// The target platform of the project
    /// (one of "web", "ios", "android" or "macos")
    public let platform: ZeplinPlatform
    /// The status of the project
    /// (one of "active" or "archived")
    public let status: String
    /// The unix timestamp when the project was created
    public let created: Double
    /// The unix timestamp when the project was updated
    public let updated: Double?
    /// The number of screens in the project
    public let numberOfScreens: Int
    /// The number of spacing tokens added to the project
    public let numberOfSpacingTokens: Int?
    /// The number of components exported to the project
    public let numberOfComponents: Int
    /// The number of text styles added to the project
    public let numberOfTextStyles: Int
    /// The number of colors added to the project
    public let numberOfColors: Int
    /// The number of members of the project
    public let numberOfMembers: Int
    /// Reference the styleguide which the project is linked to
    public let linkedStyleguide: LinkedStyleguide?
    /// Reference the organization that owns the project
    public let organization: ZeplinOrganizationSummary?

    enum CodingKeys: String, CodingKey {
        case numberOfScreens = "number_of_screens"
        case numberOfSpacingTokens = "number_of_spacing_tokens"
        case numberOfComponents = "number_of_components"
        case numberOfTextStyles = "number_of_text_styles"
        case numberOfColors = "number_of_colors"
        case numberOfMembers = "number_of_members"
        case linkedStyleguide = "linked_styleguide"
        case thumbnailURL = "thumbnail"
        case id, name, description, platform, status, created, updated, organization
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ZeplinProject {
    /// Identifier for the user activity type
    public static let domainIdentifier = "io.snappmobile.zeplin.project"

    /// The user info assigned with the user activiy
    public var userActivityUserInfo: [AnyHashable: Any] {
        return ["id": id]
    }

    /// The attribute set that describe the searchable item for the project
    public var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeBookmark as String)
        attributeSet.title = name
        attributeSet.contentDescription = "\(platform.description) project"
        return attributeSet
    }

    /// The user activity that gets triggered when the user engages the searchable item
    public var userActivity: NSUserActivity {
        let activity = NSUserActivity(activityType: ZeplinProject.domainIdentifier)
        activity.title = name
        activity.contentAttributeSet = attributeSet
        activity.userInfo = userActivityUserInfo
        activity.keywords = ["project"]
        return activity
    }
}
