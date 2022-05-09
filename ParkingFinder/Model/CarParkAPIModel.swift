//
//  CarParkAPIModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 9/5/22.
//

import Foundation
import UIKit

struct CarParkAPIModel: Codable {
    var tsn, time, spots: String
    let zones: [Zone]
    let parkID: String
    let occupancy: Occupancy
    let messageDate, facilityID, facilityName, tfnswFacilityID: String

    enum CodingKeys: String, CodingKey {
        case tsn, time, spots, zones
        case parkID = "ParkID"
        case occupancy
        case messageDate = "MessageDate"
        case facilityID = "facility_id"
        case facilityName = "facility_name"
        case tfnswFacilityID = "tfnsw_facility_id"
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
