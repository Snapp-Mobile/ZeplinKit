//
//  ZeplinLayerBorder.swift
//  
//
//  Created by Ann Kirillova on 12.01.2022.
//

import Foundation

public enum ZeplinLayerBorderPosition: String, Decodable, Sendable {
    case center, inside, outside
}

public struct ZeplinLayerBorder: Decodable, Sendable {
    public let position: ZeplinLayerBorderPosition?
    public let thickness: Double?
    public let fill: ZeplinLayerFill?
}
