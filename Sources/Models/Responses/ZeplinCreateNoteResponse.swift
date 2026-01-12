//
//  ZeplinCreateNoteResponse.swift
//
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a successful note creation response
public struct ZeplinCreateNoteResponse: Decodable, Sendable {
    /// The id of the note
    public let id: String
}
