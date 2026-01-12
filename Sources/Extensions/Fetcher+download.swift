//
//  Fetcher+download.swift
//
//
//  Created by Ilian Konchev on 29.01.22.
//

import Fetcher
import Foundation

extension Fetcher {
    func download(
        by urlString: String,
        with format: String,
        displayName: String,
        density: Double? = nil
    ) async throws -> String {
        guard let url = URL(string: urlString) else { return "" }
        let request = URLRequest(url: url)

        let data = try await perform(request)

        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var filename = "\(displayName).\(format)"
        if let density = density {
            filename = "\(displayName)@\(Int(density))x.\(format)"
        }
        let fileURL = documents.appendingPathComponent(filename)
        try data.write(to: fileURL)
        return fileURL.absoluteString
    }
}
