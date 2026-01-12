//
//  ZeplinNotePosition.swift
//
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a Zeplin note's position
///
/// Position of the note with respect to top left corner. Values are normalized in [0, 1]
public struct ZeplinNotePosition: Decodable, Hashable, Equatable, Sendable {
    /// The normalized horizontal position of the note
    public let originX: Float
    /// The normalized vertical position of the note
    public let originY: Float

    enum CodingKeys: String, CodingKey {
        case originX = "x"
        case originY = "y"
    }

    public init(originX: Float, originY: Float) {
        self.originX = originX
        self.originY = originY
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(originX)
        hasher.combine(originY)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.originX == rhs.originX && lhs.originY == rhs.originY
    }
}
