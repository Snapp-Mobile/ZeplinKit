//
//  ZeplinProjectMember.swift
//
//
//  Created by Ilian Konchev on 6.03.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a project member on Zeplin
public struct ZeplinProjectMember: Decodable, Hashable, Equatable, Sendable {
    /// The user associated with the member
    public let user: ZeplinUser
    /// The role of the user in the project
    public let role: ZeplinRole

    public func hash(into hasher: inout Hasher) {
        hasher.combine(user.email)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.user == rhs.user && lhs.role == rhs.role
    }
}
