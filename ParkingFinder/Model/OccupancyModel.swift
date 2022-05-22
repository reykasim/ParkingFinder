//
//  OccupancyModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 9/5/22.
//

import Foundation
import UIKit

// Model of API JSON
struct Occupancy: Codable {
    let loop: String?
    let total: String?
    let monthlies, openGate, transients: JSONModel?

    // API names
    enum CodingKeys: String, CodingKey {
        case loop, total, monthlies
        case openGate = "open_gate"
        case transients
    }
}
