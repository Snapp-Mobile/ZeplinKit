//
//  ZeplinGroupedAssetContent.swift
//
//  Created by Ann Kirillova on 01.12.2021.
//  Copyright © 2021 Ilian Konchev. All rights reserved.
//

import CoreGraphics
import Fetcher
import Foundation
import os.log
import UIKit
import Zip

public class ZeplinGroupedAssetContent: Hashable, Equatable, @unchecked Sendable {
    public let format: ZeplinAssetContent.Format
    public var items: [ZeplinAssetContent]
    public let displayName: String
    public let layerName: String?
    public let isAllowedDensity: [Double] = [1, 2, 3]

    public var formattedDisplayName: String {
        return layerName ?? displayName
    }

    public var downloadSubtitle: String {
        return format.downloadSubtitle(itemsCount: items.count)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(format.rawValue)
        hasher.combine(displayName)
    }

    public static func == (lhs: ZeplinGroupedAssetContent, rhs: ZeplinGroupedAssetContent) -> Bool {
        return lhs.format == rhs.format && lhs.displayName == rhs.displayName
    }

    public init(format: ZeplinAssetContent.Format,
                items: [ZeplinAssetContent],
                displayName: String,
                layerName: String?) {
        let sortedAssets = items.sorted(by: { $0.format.rawValue < $1.format.rawValue })

        self.format = format
        self.items = sortedAssets
        self.displayName = displayName
        self.layerName = layerName
    }

    public func downloadAssets(using fetcher: Fetcher) async throws -> String? {
        if format == .pdf || format == .svg {
            guard items.count == 1, let item = items.first else {
                os_log("Unexpected amount of assets", log: .viewCycle, type: .debug)
                return nil
            }
            return try await fetcher.download(by: item.url,
                                              with: item.format.rawValue,
                                              displayName: displayName)
        } else {
            return try await fetchZIPURL(using: fetcher)
        }
    }

    @Sendable
    func fetchZIPURL(using fetcher: Fetcher) async throws -> String? {
        var urls: [String] = []
        var fileName: String = ""
        try await withThrowingTaskGroup(of: String.self) { group in
            for assetContent in items where isAllowedDensity(assetContent.density) {
                fileName = displayName + "_" + format.rawValue
                group.addTask {
                    return try await fetcher.download(by: assetContent.url,
                                                      with: assetContent.format.rawValue,
                                                      displayName: self.displayName,
                                                      density: assetContent.density)
                }
            }
            for try await fileURL in group {
                urls.append(fileURL)
            }
        }

        return try zip(with: urls, fileName: fileName)
    }

    func zip(with urlStrings: [String], fileName: String) throws -> String {
        let urls = urlStrings.compactMap { URL(string: $0) }
        let zipURL = try Zip.quickZipFiles(urls, fileName: fileName)
        for url in urls {
            try? FileManager.default.removeItem(at: url)
        }
        return zipURL.absoluteString
    }

    private func isAllowedDensity(_ density: Double?) -> Bool {
        guard let density = density else {
            return false
        }
        return [1.0, 2.0, 3.0].contains(density)
    }
}
