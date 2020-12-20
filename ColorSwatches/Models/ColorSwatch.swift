//
//  ColorSwatch.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/19/20.
//

import Foundation
import UIKit

struct ColorSwatch: Codable {
    let colorName: String
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double?
}
