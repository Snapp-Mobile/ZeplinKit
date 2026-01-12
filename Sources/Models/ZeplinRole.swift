//
//  ZeplinRole.swift
//
//
//  Created by Ilian Konchev on 6.03.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a Zeplin role
public enum ZeplinRole: String, Decodable, Sendable {
    case admin
    case alien
    case editor
    case member
    case owner
    case user

    public var roleTitle: String {
        switch self {
        case .admin:
            return "Admins"
        case .alien:
            return "Others"
        case .editor:
            return "Editors"
        case .member:
            return "Members"
        case .owner:
            return "Owners"
        case .user:
            return "Users"
        }
    }

    public var order: Int {
        switch self {
        case .admin:
            return 2
        case .alien:
            return 6
        case .editor:
            return 3
        case .member:
            return 4
        case .owner:
            return 1
        case .user:
            return 5
        }
    }

    public var imageName: String {
        switch self {
        case .admin:
            return "person.crop.square"
        case .editor:
            return "pencil.circle"
        case .member:
            return "person.crop.circle"
        case .alien:
            return "person.fill.questionmark"
        default:
            return ""
        }
    }
}
