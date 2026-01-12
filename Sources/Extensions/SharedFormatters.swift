//
//  SharedFormatters.swift
//
//
//  Created by Ilian Konchev on 28.01.21.
//  Copyright © 2021 Ilian Konchev. All rights reserved.
//

import Foundation

extension RelativeDateTimeFormatter: @retroactive @unchecked Sendable {}

/// A structure containing predefined formatters
public struct SharedFormatters: Sendable {
    /// Abberviated relative datetime formatter (shows dates as "15 hr. ago", "1 day ago", etc.)
    public static let relativeDateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.locale = .current
        formatter.calendar = .current
        return formatter
    }()

    public static let numericValueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.alwaysShowsDecimalSeparator = true
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter
    }()
}
