//
//  ZeplinAddNoteRequest.swift
//
//
//  Created by Ilian Konchev on 17.07.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a request to add a note on Zeplin
///
/// Pass an instance of `ZeplinAddNoteRequest` to ``ZeplinKit/ZeplinAPIURL/addNote(_:)``
/// to create a note
///
/// ```swift
/// let addNoteRequest = ZeplinAddNoteRequest(...)
/// let url = ZeplinAPIURL.addNote(addNoteRequest)
/// let response: ZeplinCreateNoteResponse = try await Fetcher.request(url)
/// ```
public struct ZeplinAddNoteRequest: Sendable {
    /// Project to add the comment to
    public let project: ZeplinProject
    /// Screen to add the comment to
    public let screen: ZeplinScreen
    /// Normalized position of the note
    public let position: ZeplinNotePosition
    /// Note pin color
    public let color: String
    /// Content of the note
    public let content: String

    /// Create a request to add a note on Zeplin
    /// - Parameters:
    ///   - project: Project to add the comment to
    ///   - screen: Screen to add the comment to
    ///   - position: Normalized position of the note
    ///   - color: Note pin color
    ///   - content: Content of the note
    public init(
        project: ZeplinProject,
        screen: ZeplinScreen,
        position: ZeplinNotePosition,
        color: String,
        content: String
    ) {
        self.project = project
        self.screen = screen
        self.position = position
        self.color = color
        self.content = content
    }
}
