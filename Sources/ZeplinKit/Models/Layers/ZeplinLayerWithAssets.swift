//
//  ZeplinLayerWithAssets.swift
//  
//
//  Created by Ilian Konchev on 27.01.22.
//

import Foundation

public struct ZeplinLayerWithAssets: Sendable {
    public let proposedLayer: ZeplinLayer?
    public let assets: [ZeplinAsset]
    public let assetLayers: [ZeplinLayer]

    public init(proposedLayer: ZeplinLayer? = nil, assets: [ZeplinAsset] = [], assetLayers: [ZeplinLayer] = []) {
        self.proposedLayer = proposedLayer
        self.assets = assets
        self.assetLayers = assetLayers
    }
}
