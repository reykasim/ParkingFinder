//
//  ZoneModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 5/5/22.
//

import Foundation
import UIKit

struct ZoneModel: Codable{
    var spots : String
    var zoneID : String
    var occupancy : OccupancyModel
}
