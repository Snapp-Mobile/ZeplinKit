//
//  ZeplinPosition.swift
//
//
//  Created by Ilian Konchev on 13.12.21.
//

import Foundation

public struct ZeplinPosition: Decodable, Hashable, Sendable {
    public let originX, originY: Double

    enum CodingKeys: String, CodingKey {
        case originX = "x"
        case originY = "y"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(originX)
        hasher.combine(originY)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.originX == rhs.originX && lhs.originY == rhs.originY
    }
}
