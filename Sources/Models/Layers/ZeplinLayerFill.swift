//
//  ZeplinLayerFill.swift
//
//
//  Created by Ann Kirillova on 12.01.2022.
//

import Foundation
import UIKit

public enum ZeplinLayerFillType: String, Decodable, Sendable {
    case color, gradient
}

public enum ZeplinGradientType: String, Decodable, Sendable {
    case linear, radial, angular
}

public struct ZeplinLayerFill: Decodable, Sendable {
    public let type: ZeplinLayerFillType
    public let color: ZeplinColorData?
    public let gradient: ZeplinGradient?

    enum CodingKeys: String, CodingKey {
        case type
        case color
        case gradient
    }
}

public struct ZeplinColorData: Decodable, Hashable, Equatable, Sendable, CustomStringConvertible, ZeplinColorComponents {
    public let sourceId: String?
    public let red: Int
    public let green: Int
    public let blue: Int
    public let alpha: Double

    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case red = "r"
        case green = "g"
        case blue = "b"
        case alpha = "a"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(red)
        hasher.combine(green)
        hasher.combine(blue)
        hasher.combine(alpha)
    }

    /// `UIColor` representation of the color
    public var color: UIColor {
        return UIColor(
            displayP3Red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha))
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.red == rhs.red
            && lhs.green == rhs.green
            && lhs.blue == rhs.blue
            && lhs.alpha == rhs.alpha
            && lhs.sourceId == rhs.sourceId
    }

    public var description: String {
        if alpha != 1 {
            let formattedAlpha = SharedFormatters.numericValueFormatter.string(from: NSNumber(value: alpha)) ?? "0.0"
            return "R: \(red), G: \(green), B: \(blue), A: \(formattedAlpha)"
        } else {
            return "R: \(red), G: \(green) B: \(blue)"
        }
    }
}

public struct ZeplinGradient: Decodable, Sendable {
    public let type: ZeplinGradientType?
    public let angle: Double?
    public let scale: Double?
    public let colorStops: [ZeplinColorStop]?
    public let opacity: Double?

    enum CodingKeys: String, CodingKey {
        case colorStops = "color_stops"
        case type, angle, scale, opacity
    }
}

public struct ZeplinColorStop: Decodable, Sendable {
    public let color: ZeplinColorData
    public let position: Double
}
