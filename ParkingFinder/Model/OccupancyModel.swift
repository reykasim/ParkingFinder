//
//  OccupancyModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 9/5/22.
//

import Foundation
import UIKit

struct Occupancy: Codable {
    let loop: String?
    let total: String?
    //let total: String
    let monthlies, openGate, transients: JSONNull?

    enum CodingKeys: String, CodingKey {
        case loop, total, monthlies
        case openGate = "open_gate"
        case transients
    }
}
