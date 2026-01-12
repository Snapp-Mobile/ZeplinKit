//
//  ZeplinLayer.swift
//
//
//  Created by Ilian Konchev on 26.01.22.
//

import Foundation

public enum ZeplinLayerType: String, Decodable, Sendable {
    case text, shape, group
}

public struct ZeplinLayer: Decodable, Hashable, Sendable {
    public let id: String
    public let type: ZeplinLayerType
    public let content: String?
    public let name: String?
    public var rect: ZeplinBoundingRectangle
    public let layers: [ZeplinLayer]?
    public let textStyles: [ZeplinLayerTextStyle]?
    public let sourceId: String?
    public let fills: [ZeplinLayerFill]?
    public let borders: [ZeplinLayerBorder]?
    public let shadows: [ZeplinLayerShadow]?
    public let blur: ZeplinLayerBlur?
    public let borderRadius: Double?
    public let blendMode: String?
    public let opacity: Double?
    public let rotation: Double?
    public let exportable: Bool?

    enum CodingKeys: String, CodingKey {
        case id, type, name, content, rect, layers, fills, borders, shadows, blur, opacity, rotation, exportable
        case textStyles = "text_styles"
        case sourceId = "source_id"
        case borderRadius = "border_radius"
        case blendMode = "blend_mode"
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
