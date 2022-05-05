//
//  ParkingSavedModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 5/5/22.
//

import Foundation
import UIKit

struct ParkingSavedModel: Codable{
    var address: AddressModel
    var facilityInformation : FacilityInformationModel
    var occupancy : OccupancyModel
}
