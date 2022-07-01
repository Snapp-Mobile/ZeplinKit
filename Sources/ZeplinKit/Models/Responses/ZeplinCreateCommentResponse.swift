//
//  ZeplinCreateCommentResponse.swift
//  
//
//  Created by Ilian Konchev on 13.02.20.
//  Copyright © 2020 Ilian Konchev. All rights reserved.
//

import Foundation

/// A model that represents a successful comment creation response
public struct ZeplinCreateCommentResponse: Decodable {
    /// The is of the comment
    public let id: String
}
