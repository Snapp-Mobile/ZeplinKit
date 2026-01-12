//
//  Date+beforize.swift
//
//
//  Created by Ilian Konchev on 28.01.21.
//  Copyright © 2021 Ilian Konchev. All rights reserved.
//

import Foundation

extension Date {

    /// Formate the date using ``ZeplinKit/SharedFormatters/relativeDateFormatter``
    /// - Returns: A string containing the formatted date
    public func beforized() -> String {
        return SharedFormatters.relativeDateFormatter.localizedString(for: self, relativeTo: Date())
    }
}
