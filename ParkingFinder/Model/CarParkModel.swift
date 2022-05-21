//
//  CarParkModel.swift
//  ParkingFinder
//
//  Created by Lily Ngo on 9/5/22.
//

import Foundation
import UIKit

struct CarParkModels: Codable{
    var carParkID : String
    var carParkName : String
    var carParkCoor : String
}

var carParkList = [
    CarParkModels(carParkID: "1", carParkName: "Tallawong Station Car Park", carParkCoor: "-33.69163,150.906022"),
    CarParkModels(carParkID: "2", carParkName: "Kellyville Station Car Park", carParkCoor: "-33.713514,150.935304"),
    CarParkModels(carParkID: "3", carParkName: "Bella Vista Station Car Park", carParkCoor: "-33.730592,150.944024"),
    CarParkModels(carParkID: "4", carParkName: "Hills Showground Station Car Park", carParkCoor: "-33.72782,150.987345"),
    CarParkModels(carParkID: "5", carParkName: "Cherrybrook Station Car Park", carParkCoor: "-33.736703,151.031977"),
    CarParkModels(carParkID: "6", carParkName: "Gordon Henry St North Car Park", carParkCoor: "-33.756009,151.154528"),
    CarParkModels(carParkID: "7", carParkName: "Kiama Car Park", carParkCoor: "-34.672518,150.854695"),
    CarParkModels(carParkID: "9", carParkName: "Revesby Car Park", carParkCoor: "-33.95246,151.014838"),
    CarParkModels(carParkID: "10", carParkName: "Warriewood Car Park", carParkCoor: "33.697777,151.300667"),
    CarParkModels(carParkID: "11", carParkName: "Narrabeen Car Park ", carParkCoor: " -33.713514,151.297315"),
    CarParkModels(carParkID: "12", carParkName: "Mona Vale Car Park", carParkCoor: "-33.677276,151.305146"),
    CarParkModels(carParkID: "13", carParkName: "Dee Why Car Park", carParkCoor: "-33.752797,151.286485"),
    CarParkModels(carParkID: "14", carParkName: "West Ryde Car Park", carParkCoor: "-33.807172,151.090229"),
    CarParkModels(carParkID: "15", carParkName: "Sutherland East Parade Car Park", carParkCoor: "-34.031787,151.05719"),
    CarParkModels(carParkID: "16", carParkName: "Leppington Car Park", carParkCoor: "-33.9544,150.8081"),
    CarParkModels(carParkID: "17", carParkName: "Edmondson Park South Car Park", carParkCoor: "-33.9693,150.8587")
]

class CarParkModel {
    init () {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(carParkList), forKey: "PARKING")
    }
        
    func requestData(completion: ((_ data: [CarParkModels]) -> Void)) {
        let data = carParkList
        completion(data)
    }
    
}


