//
//  CarParkOccupancyModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 5/5/22.
//

import Foundation
import UIKit

struct CarParkOccupancyModel: Codable{
    var parkingSpots : String
    var parkingZones : ZoneModel
    var facilityId : String
    var facilityName : String
    var tfnswFacilityId : String
}
