//
//  ParkingSavedModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 5/5/22.
//

import Foundation
import UIKit

// Model of API JSON
struct ParkingSavedModel: Codable{
    var carParkID : String
    var savedParkingLot : String
    var carParkZones : String
}
