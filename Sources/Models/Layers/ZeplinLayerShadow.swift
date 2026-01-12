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
    public let type: ZeplinLayerShadowType?
    public let offsetX: Double?
    public let offsetY: Double?
    public let blurRadius: Double?
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
