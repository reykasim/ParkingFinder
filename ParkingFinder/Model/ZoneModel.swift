//
//  ZoneModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 9/5/22.
//

import Foundation
import UIKit

// Model of API JSON
struct Zone: Codable {
    let spots, zoneID: String
    let occupancy: Occupancy
    let zoneName, parentZoneID: String

    // API names
    enum CodingKeys: String, CodingKey {
        case spots
        case zoneID = "zone_id"
        case occupancy
        case zoneName = "zone_name"
        case parentZoneID = "parent_zone_id"
    }
}
