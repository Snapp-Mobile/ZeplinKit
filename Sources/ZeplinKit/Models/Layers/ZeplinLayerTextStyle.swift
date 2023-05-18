//
//  ZeplinLayerTextStyle.swift
//  
//
//  Created by Ilian Konchev on 13.12.21.
//

import Foundation

public struct ZeplinLayerTextStyle: Decodable, Sendable {
    public let range: ZeplinTextStyleRange?
    public let style: ZeplinTextStyleData?
}

public struct ZeplinTextStyleRange: Decodable, Sendable {
    public let location: Double?
    public let length: Double?
}

public struct ZeplinTextStyleData: Decodable, Sendable {
    public let postscriptName: String
    public let fontFamily: String
    public let fontSize, fontWeight: Double
    public let fontStyle: String
    public let fontStretch: Double
    public let lineHeight: Int?
    public let letterSpacing: Double?
    public let textAlign: String?
    public let color: ZeplinColor?

    enum CodingKeys: String, CodingKey {
            case postscriptName = "postscript_name"
            case fontFamily = "font_family"
            case fontSize = "font_size"
            case fontWeight = "font_weight"
            case fontStyle = "font_style"
            case fontStretch = "font_stretch"
            case lineHeight = "line_height"
            case letterSpacing = "letter_spacing"
            case textAlign = "text_align"
            case color
        }
}
