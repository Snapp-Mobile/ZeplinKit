//
//  ZeplinLinkDestination.swift
//
//
//  Created by Ilian Konchev on 4.02.22.
//

import Foundation

public struct ZeplinLinkDestination: Decodable, Hashable, Equatable, Sendable {
    public enum DestinationType: String, Decodable, Sendable {
        case screen, component, previous
    }

    public let name: String
    public let type: DestinationType

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}
