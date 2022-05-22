//
//  CarParkAPIModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 9/5/22.
//

import Foundation
import UIKit

// Model of API JSON
struct CarParkAPIModel: Codable {
    var tsn, time, spots: String
    let zones: [Zone]
    let parkID: String
    let occupancy: Occupancy
    let messageDate, facilityID, facilityName, tfnswFacilityID: String

    // API names
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

// API URL
let carParkUrl = "https://api.transport.nsw.gov.au/v1/carpark?facility="

// API functions
class JSONModel: Codable, Hashable {

    // API Equatable protocol
    public static func == (lhs: JSONModel, rhs: JSONModel) -> Bool {
        return true
    }
    // API cookies
    public var hashValue: Int {
        return 0
    }

    public init() {}

    // API error handling
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONModel.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    // API encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
    
    // Get car parks from API
    func carParks(_ carParkID: String) -> CarParkAPIModel {
        // Varibles definition
        let url = URL(string: carParkUrl + carParkID)!
        var carParkDetails: CarParkAPIModel?
        var request = URLRequest(url: url)
        
        // API call protocol
        request.httpMethod = "GET"
        request.addValue("apikey fyQ2UwCzxYDSwJRbc58uZkwGoioNfMOs6yVj", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Set a wait function for API call
        let semaphore = DispatchSemaphore(value: 0)
        
        // Calling API
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
 
            // Load the API data
            do{
                carParkDetails = try! JSONDecoder().decode(CarParkAPIModel.self, from: data )
                // Stop the wait function
                semaphore.signal()
            }
            
        // Continue code after API call
        }.resume()
        // Wait for the API data to load
        semaphore.wait()
        // Push API data
        return carParkDetails!
    }

}
