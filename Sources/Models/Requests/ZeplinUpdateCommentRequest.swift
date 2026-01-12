//
//  ZeplinUpdateCommentRequest.swift
//  
//
//  Created by Ilian Konchev on 17.07.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a request to update a comment on Zeplin
///
/// Pass an instance of `ZeplinUpdateCommentRequest` to ``ZeplinKit/ZeplinAPIURL/updateComment(_:)``
/// to update a comment
///
/// ```swift
/// let updateCommentRequest = ZeplinUpdateCommentRequest(...)
/// let url = ZeplinAPIURL.updateNote(updateCommentRequest)
/// let success: Bool = try await Fetcher.request(url)
/// ```
public struct ZeplinUpdateCommentRequest: Sendable {
    /// Project that owns the comment
    public let project: ZeplinProject
    /// Screen that the comment is on
    public let screen: ZeplinScreen
    /// Note that owns the comment
    public let note: ZeplinNote
    /// The comment to update
    public let comment: ZeplinComment
    /// The updated content
    public let content: String

    /// Create a request to update a comment on Zeplin
    /// - Parameters:
    ///   - project: Project that owns the comment
    ///   - screen: Screen that the comment is on
    ///   - note: Note that owns the comment
    ///   - comment: The comment to update
    ///   - content: The updated content
    public init(project: ZeplinProject,
                screen: ZeplinScreen,
                note: ZeplinNote,
                comment: ZeplinComment,
                content: String) {
        self.project = project
        self.screen = screen
        self.note = note
        self.comment = comment
        self.content = content
    }
}
