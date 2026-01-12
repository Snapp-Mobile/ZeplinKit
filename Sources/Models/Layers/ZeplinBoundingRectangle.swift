//
//  ZeplinBoundingRectangle.swift
//  
//
//  Created by Ilian Konchev on 13.12.21.
//

import CoreGraphics
import Foundation

public struct ZeplinBoundingRectangle: Decodable, Hashable, Sendable {
    public var originY, originX, width, height: Double
    public let absolute: ZeplinPosition

    enum CodingKeys: String, CodingKey {
        case width, height, absolute
        case originX = "x"
        case originY = "y"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(originX)
        hasher.combine(originY)
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(absolute)
    }

    public static func * (left: ZeplinBoundingRectangle, right: CGFloat) -> ZeplinBoundingRectangle {
        return ZeplinBoundingRectangle(originY: left.absolute.originY * right,
                                       originX: left.absolute.originX * right,
                                       width: left.width * right,
                                       height: left.height * right,
                                       absolute: left.absolute)
    }

    // swiftlint:disable shorthand_operator
    public static func *= (left: inout ZeplinBoundingRectangle, right: CGFloat) {
        left = left * right
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.originX == rhs.originX
        && lhs.originY == rhs.originY
        && lhs.width == rhs.width
        && lhs.height == rhs.height
        && lhs.absolute == rhs.absolute
    }

    public var rectangle: CGRect {
        CGRect(x: self.originX, y: self.originY, width: self.width, height: self.height)
    }

    public func contains(_ point: CGPoint) -> Bool {
        return point.x >= absolute.originX
        && point.x <= absolute.originX + width
        && point.y >= absolute.originY
        && point.y <= absolute.originY + height
    }

}
