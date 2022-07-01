//
//  ZeplinNotificationScreenVersion.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to screens in a project.
public struct ZeplinNotificationScreenVersion: Codable, CustomStringConvertible, Sendable {
    /// The URL of the version image
    public let imageURL: String
    /// The URLS of the thumbnails
    public let thumbnails: [String: String]
    /// The width of the version image
    public let width: Float
    /// The height of the version image
    public let height: Float

    enum CodingKeys: String, CodingKey {
        case thumbnails, width, height
        case imageURL = "image_url"
    }

    /// User-friendly representation of the screen version
    public var description: String {
        return ""
    }
}
