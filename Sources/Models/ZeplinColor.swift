//
//  ZeplinColor.swift
//
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation
import UIKit

public protocol ZeplinColorComponents: Sendable {
    var red: Int { get }
    var green: Int { get }
    var blue: Int { get }
    var alpha: Double { get }
}

/// A model that represents a Zeplin color
public struct ZeplinColor: Codable, Hashable, Sendable, CustomStringConvertible, ZeplinColorComponents {
    /// Name of the color
    public let alpha: Double
    /// Red component of the color
    public let red: Int
    /// Green component of the color
    public let green: Int
    /// Blue component of the color
    public let blue: Int
    /// Name of the color
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case alpha = "a"
        case red = "r"
        case green = "g"
        case blue = "b"
        case name
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(red)
        hasher.combine(green)
        hasher.combine(blue)
        hasher.combine(alpha)
    }

    /// `UIColor` representation of the color
    public var color: UIColor {
        return UIColor(displayP3Red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha))
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.red == rhs.red && lhs.green == rhs.green && lhs.blue == rhs.blue && lhs.alpha == rhs.alpha && lhs.name == rhs.name
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
