//
//  Wrapper.swift
//  
//
//  Created by Ilian Konchev on 4.11.21.
//

import Foundation

/// A helper object used to wrap the notification context components
public struct Wrapper<T: Codable & CustomStringConvertible & Sendable>: Codable, CustomStringConvertible, Sendable {
    /// The id of the wrapped components
    public let id: String
    /// The type of the wrapped component
    public let type: String
    /// The object representing the component
    public let extra: T

    /// User-friendly representation of the wrapped object
    public var description: String {
        return extra.description
    }
}
