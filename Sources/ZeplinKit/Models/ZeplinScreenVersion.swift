//
//  ZeplinScreenVersion.swift
//
//
//  Created by Ann Kirillova on 15.11.2021.
//

import Foundation

public struct ZeplinScreenVersion: Decodable, Hashable, Identifiable, Sendable {
    public var id: String
    public var creator: ZeplinUser?
    public var commit: ZeplinScreenVersionCommit?
    public let width: Double
    public let height: Double
    public let imageURL: String?
    public let source: String
    public let density: Double
    public let backgroundColor: ZeplinColorData?
    public let grid: ZeplinGrid?
    public let links: [ZeplinLink]
    public let layers: [ZeplinLayer]
    public let assets: [ZeplinAsset]

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case backgroundColor = "background_color"
        case density = "density_scale"
        case id, width, height, source, layers, assets, grid, links, creator, commit
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
