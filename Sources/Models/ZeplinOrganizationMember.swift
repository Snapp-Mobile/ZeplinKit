//
//  ZeplinOrganizationMember.swift
//
//
//  Created by Ilian Konchev on 7.02.22.
//

import Foundation

public struct ZeplinOrganizationMember: Decodable, Hashable, Equatable, Sendable {
    public let user: ZeplinUser
    public let role: ZeplinRole
    public let restricted: Bool
    public let tags: [String]
    public let invited: Double?

    public func hash(into hasher: inout Hasher) {
        hasher.combine(user.id)
        hasher.combine(role.rawValue)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.user == rhs.user
            && lhs.role == rhs.role
            && lhs.restricted == rhs.restricted
            && lhs.tags == rhs.tags
            && lhs.invited == rhs.invited
    }
}
