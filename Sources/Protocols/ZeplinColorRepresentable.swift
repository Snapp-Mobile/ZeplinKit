//
//  ZeplinColorRepresentable.swift
//
//
//  Created by Ilian Konchev on 22.01.22.
//

import Foundation
import UIKit

public protocol ZeplinColorRepresentable: Hashable {
    var red: Int { get }
    var green: Int { get }
    var blue: Int { get }
    var alpha: Double { get }
    var color: UIColor { get }
    var description: String { get }
}
