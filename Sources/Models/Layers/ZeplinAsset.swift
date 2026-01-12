//
//  ZeplinAsset.swift
//
//
//  Created by Ilian Konchev on 13.12.21.
//

import Foundation
import UIKit

public struct ZeplinAsset: Decodable, Sendable {
    public let layerSourceID, layerName: String?
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

    public let url: String
    public let format: Format
    public let density: Double?
}
