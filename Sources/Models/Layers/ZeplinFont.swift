//
//  File.swift
//
//
//  Created by Ilian Konchev on 19.01.22.
//

import Foundation

struct ZeplinFont: Decodable, CustomStringConvertible, Sendable {
    let name: String

    var description: String {
        return name
    }
}
