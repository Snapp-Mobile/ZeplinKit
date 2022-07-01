//
//  ZeplinAddCommentRequest.swift
//  
//
//  Created by Ilian Konchev on 17.07.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a request to add a comment on Zeplin
///
/// Pass an instance of `ZeplinAddComentRequest` to ``ZeplinKit/ZeplinAPIURL/addComment(_:)``
/// to create a comment
///
/// ```swift
/// let addCommentRequest = ZeplinAddCommentRequest(...)
/// let url = ZeplinAPIURL.addComment(addCommentRequest)
/// let response: ZeplinCreateCommentResponse = try await Fetcher.request(url)
/// ```
public struct ZeplinAddCommentRequest: Sendable {
    /// Project to add the comment to
    public let project: ZeplinProject
    /// Screen to add the comment to
    public let screen: ZeplinScreen
    /// Note to add the comment to
    public let note: ZeplinNote
    /// Content of the comment
    public let content: String

    /// Create a request to add a comment on Zeplin
    /// - Parameters:
    ///   - project: Project to add the comment to
    ///   - screen: Screen to add the comment to
    ///   - note: Note to add the comment to
    ///   - content: Content of the comment
    public init(project: ZeplinProject, screen: ZeplinScreen, note: ZeplinNote, content: String) {
        self.project = project
        self.screen = screen
        self.note = note
        self.content = content
    }
}
