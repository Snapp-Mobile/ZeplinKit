//
//  ZeplinScreenVersionCommit.swift
//  
//
//  Created by Ilian Konchev on 27.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a screen version commit on Zeplin
public struct ZeplinScreenVersionCommit: Decodable, Sendable {
    /// Commit message for the version
    public let message: String?
    /// Author of the version commit
    public let author: ZeplinUser?
    /// Color associated with the version commit
    public let color: ZeplinColor?
}
