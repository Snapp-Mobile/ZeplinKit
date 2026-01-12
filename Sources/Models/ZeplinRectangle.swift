//
//  ZeplinRectangle.swift
//
//
//  Created by Ilian Konchev on 4.02.22.
//

import Foundation

public struct ZeplinRectangle: Decodable, Hashable, Equatable, Sendable {
    public let originX: Double
    public let originY: Double
    public let width: Double
    public let height: Double

    enum CodingKeys: String, CodingKey {
        case originX = "x"
        case originY = "y"
        case width, height
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(originX)
        hasher.combine(originY)
        hasher.combine(width)
        hasher.combine(height)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.originX == rhs.originX
            && lhs.originY == rhs.originY
            && lhs.width == rhs.width
            && lhs.height == rhs.height
    }
}
