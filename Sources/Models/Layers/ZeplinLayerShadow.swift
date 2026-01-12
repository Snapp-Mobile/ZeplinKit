//
//  ZeplinLayerShadow.swift
//
//
//  Created by Ann Kirillova on 12.01.2022.
//

import Foundation

public enum ZeplinLayerShadowType: String, Decodable, Sendable {
    case outer, inner
}

public struct ZeplinLayerShadow: Decodable, Sendable {
    /// Type of the shadow
    public let type: ZeplinLayerShadowType?
    /// Horizontal offset of the shadow
    public let offsetX: Double?
    /// Vertical offset of the shadow
    public let offsetY: Double?
    /// Blur radius of the shadow
    public let blurRadius: Double?
    /// Spread of the shadow
    public let spread: Double?
    public let color: ZeplinColorData?

    enum CodingKeys: String, CodingKey {
        case type
        case offsetX = "offset_x"
        case offsetY = "offset_y"
        case blurRadius = "blur_radius"
        case spread
        case color
    }
}
