//
//  ZeplinAddNoteRequest.swift
//
//
//  Created by Ilian Konchev on 17.07.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a request to update a note on Zeplin
///
/// Pass an instance of `ZeplinUpdateNoteRequest` to ``ZeplinKit/ZeplinAPIURL/updateNote(_:)``
/// to update a note
///
/// ```swift
/// let updateNoteRequest = ZeplinUpdateNoteRequest(...)
/// let url = ZeplinAPIURL.updateNote(updateNoteRequest)
/// let success: Bool = try await Fetcher.request(url)
/// ```
public struct ZeplinUpdateNoteRequest: Sendable {
    /// Project that owns the note
    public let project: ZeplinProject
    /// Screen that the note is on
    public let screen: ZeplinScreen
    /// The note to update
    public let note: ZeplinNote
    /// The updated note position
    public let position: ZeplinNotePosition
    /// The updated note status (see ``ZeplinKit/ZeplinNote/status-swift.property``)
    public let status: String?

    /// Create a request to update a note on Zeplin
    /// - Parameters:
    ///   - project: Project that owns the note
    ///   - screen: Screen that the note is on
    ///   - note: The note to update
    ///   - position: The updated note position
    ///   - status: The updated note status
    public init(
        project: ZeplinProject,
        screen: ZeplinScreen,
        note: ZeplinNote,
        position: ZeplinNotePosition,
        status: String?
    ) {
        self.project = project
        self.screen = screen
        self.note = note
        self.position = position
        self.status = status
    }
}
