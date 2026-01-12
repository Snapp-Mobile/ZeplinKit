//
//  ZeplinNotificationTextStyle.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// Notification data used for changes related to text styles in a styleguide.
public struct ZeplinNotificationTextStyle: Codable, CustomStringConvertible, Sendable {
    /// The name of the text style
    public let name: String

    /// User-friendly representation of the text style name
    public var description: String {
        return name
    }
}
