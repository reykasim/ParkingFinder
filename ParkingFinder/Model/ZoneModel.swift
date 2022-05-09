//
//  ZoneModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 9/5/22.
//

import Foundation
import UIKit

struct Zone: Codable {
    let spots, zoneID: String
    let occupancy: Occupancy
    let zoneName, parentZoneID: String

    enum CodingKeys: String, CodingKey {
        case spots
        case zoneID = "zone_id"
        case occupancy
        case zoneName = "zone_name"
        case parentZoneID = "parent_zone_id"
    }
}
