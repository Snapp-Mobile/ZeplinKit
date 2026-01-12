//
//  ZeplinLink.swift
//
//
//  Created by Ilian Konchev on 4.02.22.
//

import Foundation

public struct ZeplinLink: Decodable, Hashable, Equatable, Sendable {
    public let rect: ZeplinRectangle
    public let destination: ZeplinLinkDestination

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rect)
        hasher.combine(destination)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rect == rhs.rect && lhs.destination == rhs.destination
    }
}
