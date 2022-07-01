//
//  ZeplinLayerBlur.swift
//  
//
//  Created by Ann Kirillova on 12.01.2022.
//

import Foundation

public enum ZeplinLayerBlurType: String, Decodable, Sendable {
    case gaussian, background
}

public struct ZeplinLayerBlur: Decodable, Sendable {
    public let type: ZeplinLayerBlurType?
    public let radius: Double?
}
