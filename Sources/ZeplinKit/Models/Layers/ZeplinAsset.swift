//
//  ZeplinAsset.swift
//  
//
//  Created by Ilian Konchev on 13.12.21.
//

import Foundation
import UIKit

/// Assets are automatically generated while exporting designs based on the platform the design is exported.
/// Asset formats and densities change according to these platforms.
///
/// | Platform | Formats |
/// |:---------|:--------|
/// | Base | PNG (1.0, 1.5, 2.0, 3.0, 4.0), and PDF |
/// | Web | PNG (1.0, 2.0, 3.0), SVG, and JPG (bitmap image) |
/// | iOS | PNG (1.0, 2.0, 3.0), and PDF |
/// | Android | PNG (1.0, 1.5, 2.0, 3.0, 4.0), and SVG |
public struct ZeplinAsset: Decodable, Sendable {
    /// Layer's identifier in the design tool
    public let layerSourceID: String?
    /// Name of the layer containing the asset
    public let layerName: String?
    /// Display name of the asset
    public let displayName: String
    public var contents: [ZeplinAssetContent]

    enum CodingKeys: String, CodingKey {
        case layerSourceID = "layer_source_id"
        case layerName = "layer_name"
        case displayName = "display_name"
        case contents
    }

    public func groupedByType() -> [ZeplinGroupedAssetContent] {
        guard !contents.isEmpty else { return [] }

        var assetGroupedByType: [ZeplinGroupedAssetContent] = []
        if contents.count == 1, let content = contents.first {
            assetGroupedByType = [
                ZeplinGroupedAssetContent(format: content.format, items: [content], displayName: displayName, layerName: layerName)
            ]
        } else {
            for content in contents {
                if let assetContent = assetGroupedByType.first(where: { $0.format == content.format }) {
                    assetContent.items.append(content)
                } else {
                    assetGroupedByType.append(
                        ZeplinGroupedAssetContent(
                            format: content.format,
                            items: [content],
                            displayName: displayName,
                            layerName: layerName
                        )
                    )
                }
            }
        }
        return assetGroupedByType
    }
}

public struct ZeplinAssetContent: Decodable, Sendable {

    public enum Format: String, Decodable, Comparable, Sendable {
        public static func < (
            lhs: ZeplinAssetContent.Format,
            rhs: ZeplinAssetContent.Format
        ) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }

        case png, jpg, svg, pdf

        func downloadSubtitle(itemsCount: Int) -> String {
            let wordEnding: String = itemsCount == 1 ? "image" : "images"
            let itemsCount = itemsCount <= 3 ? itemsCount : 3

            switch self {
            case .png:
                return "\(itemsCount) bitmap \(wordEnding)"
            case .jpg:
                return "\(itemsCount) selected bitmap \(wordEnding)"
            case .svg:
                return "\(itemsCount) optimized vector \(wordEnding)"
            case .pdf:
                return "\(itemsCount) vector \(wordEnding)"
            }
        }
    }

    /// URL of the asset content
    public let url: String
    /// Format of the asset content
    public let format: Format
    /// Density of the asset content
    public let density: Double?
}
