//
//  AddressModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 5/5/22.
//

import Foundation
import UIKit

struct AddressModel: Codable{
    var parkingAddress : String
    var parkingState : String
    var parkingPostcode : Int
    var parkingCountry : String
}
