//
//  ZeplinNamedColor.swift
//
//
//  Created by Ilian Konchev on 7.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import UIKit

/// A model that represents a Zeplin named color
///
/// There are 7 predefined colors to use with the Zeplin API. These colors are used for the note pins
public enum ZeplinNamedColor: String, Sendable {
    case yellow, orange, peach, green, turquoise
    case cornflowerBlue = "cornflower_blue"
    case deepPurple = "deep_purple"

    public var color: UIColor {
        switch self {
        case .yellow:
            return UIColor(named: "zeplinYellow") ?? .systemYellow
        case .orange:
            return UIColor(named: "zeplinOrange") ?? .systemOrange
        case .peach:
            return UIColor(named: "zeplinPeach") ?? .systemRed
        case .green:
            return UIColor(named: "zeplinGreen") ?? .systemGreen
        case .turquoise:
            return UIColor(named: "zeplinTurquoise") ?? .systemTeal
        case .cornflowerBlue:
            return UIColor(named: "zeplinCornflowerBlue") ?? .systemBlue
        case .deepPurple:
            return UIColor(named: "zeplinDeepPurple") ?? .systemPurple
        }
    }

    public func toNoteColor() -> ZeplinColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        self.color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return ZeplinColor(alpha: Double(alpha), red: Int(red * 255), green: Int(green * 255), blue: Int(blue * 255), name: self.rawValue)
    }
}
