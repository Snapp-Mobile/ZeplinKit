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
    /// Layer's unique id
    public let id: String
    /// Type of the layer
    public let type: ZeplinLayerType
    /// Text of the text layer
    public let content: String?
    /// Name of the layer
    public let name: String?
    /// Bounding rectangle of the layer
    public var rect: ZeplinBoundingRectangle
    public let layers: [ZeplinLayer]?
    public let textStyles: [ZeplinLayerTextStyle]?
    /// Layer's identifier in the design tool
    public let sourceId: String?
    /// Fills applied to the layer
    public let fills: [ZeplinLayerFill]?
    /// Borders of the layer
    public let borders: [ZeplinLayerBorder]?
    /// Shadows applied to the layer
    public let shadows: [ZeplinLayerShadow]?
    public let blur: ZeplinLayerBlur?
    /// Border radius of the layer
    public let borderRadius: Double?
    public let blendMode: ZeplinBlendMode?
    /// Opacity of the layer, [0, 1]
    public let opacity: Double?
    /// Rotation of the layer
    public let rotation: Double?
    /// Indicates whether the layer has assets or not
    public let exportable: Bool?
    /// Name of the component the group layer is referencing
    public let componentName: String?

    enum CodingKeys: String, CodingKey {
        case id, type, name, content, rect, layers, fills, borders, shadows, blur, opacity, rotation, exportable
        case textStyles = "text_styles"
        case sourceId = "source_id"
        case borderRadius = "border_radius"
        case blendMode = "blend_mode"
        case componentName = "component_name"
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
