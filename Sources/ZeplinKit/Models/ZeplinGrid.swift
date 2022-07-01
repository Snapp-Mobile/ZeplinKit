//
//  ZeplinGrid.swift
//  
//
//  Created by Ilian Konchev on 4.02.22.
//

import Foundation

public struct ZeplinHorizontalGrid: Decodable, Hashable, Equatable, Sendable {
    public let gutterHeight: Double
    public let numberOfRows: Int
    public let rowHeight: Double

    enum CodingKeys: String, CodingKey {
        case gutterHeight = "gutter_height"
        case numberOfRows = "number_of_rows"
        case rowHeight = "row_height"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(gutterHeight)
        hasher.combine(rowHeight)
        hasher.combine(numberOfRows)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.gutterHeight == rhs.gutterHeight
        && lhs.numberOfRows == rhs.numberOfRows
        && lhs.rowHeight == rhs.rowHeight
    }
}

public struct ZeplinVerticalGrid: Decodable, Hashable, Equatable, Sendable {
    public let columnWidth: Double
    public let numberOfColumns: Int
    public let gutterWidth: Double
    public let guttersOnOutside: Bool

    enum CodingKeys: String, CodingKey {
        case columnWidth = "column_width"
        case numberOfColumns = "number_of_cols"
        case gutterWidth = "gutter_width"
        case guttersOnOutside = "gutters_on_outside"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(columnWidth)
        hasher.combine(gutterWidth)
        hasher.combine(numberOfColumns)
        hasher.combine(guttersOnOutside)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.gutterWidth == rhs.gutterWidth
        && lhs.numberOfColumns == rhs.numberOfColumns
        && lhs.columnWidth == rhs.columnWidth
        && lhs.guttersOnOutside == rhs.guttersOnOutside
    }
}

public struct ZeplinGrid: Decodable, Hashable, Equatable, Sendable {
    public let horizontalOffset: Double?
    public let verticalOffset: Double?

    public let horizontalGrid: ZeplinHorizontalGrid?
    public let verticalGrid: ZeplinVerticalGrid?

    enum CodingKeys: String, CodingKey {
        case horizontalOffset = "horizontal_offset"
        case verticalOffset = "vertical_offset"
        case horizontalGrid = "horizontal"
        case verticalGrid = "vertical"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(horizontalOffset)
        hasher.combine(verticalOffset)
        hasher.combine(horizontalGrid)
        hasher.combine(verticalGrid)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.horizontalOffset == rhs.horizontalOffset
        && lhs.verticalOffset == rhs.verticalOffset
        && lhs.horizontalGrid == rhs.horizontalGrid
        && lhs.verticalGrid == rhs.verticalGrid
    }
}
