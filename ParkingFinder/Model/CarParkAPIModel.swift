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

let carParkUrl = "https://api.transport.nsw.gov.au/v1/carpark?facility="

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
    
    
    
    func carParks(_ carParkID: String) -> CarParkAPIModel {
        let url = URL(string: carParkUrl + carParkID)!
        var carParkDetails: CarParkAPIModel?
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("apikey fyQ2UwCzxYDSwJRbc58uZkwGoioNfMOs6yVj", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }

            if let stra = String(data: data, encoding: .utf8) {
                print(stra)
            }
 
            do{
                carParkDetails = try! JSONDecoder().decode(CarParkAPIModel.self, from: data )
                semaphore.signal()
                //return carParkDetails
                // welcome
          //      print(welcome!.zones.count)
        //        print(welcome!.zones.)
                // print(welcome?.zoneName)
                // zones
                
                // carParkDetails.spots // gets total spots
                
//                for zone in carParkDetails!.zones{
//                    print(zone.spots) //total zone spot
                    // zone.occupancy.total // how much spots avaible
                // zone.zone_name // zone name
//                }
            }
            
            
        }.resume()
        semaphore.wait()
        return carParkDetails!
    }

}
