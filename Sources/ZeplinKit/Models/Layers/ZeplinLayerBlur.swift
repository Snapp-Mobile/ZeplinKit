//
//  ZeplinLayerBlur.swift
//  
//
//  Created by Ann Kirillova on 12.01.2022.
//

import Foundation

/// Blur applied to the layer
public enum ZeplinLayerBlurType: String, Decodable, Sendable {
    case gaussian, background
}

public struct ZeplinLayerBlur: Decodable, Sendable {
    /// Type of the blur
    public let type: ZeplinLayerBlurType?
    /// Radius of the blur
    public let radius: Double?
}
