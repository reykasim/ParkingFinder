//
//  ParkingDetailsViewController.swift
//  ParkingFinder
//
//  Created by Vivian The on 5/5/2022.
//

import Foundation


import UIKit

class ParkingDetailsViewController: UIViewController {

    @IBOutlet weak var carparkNameLabel: UILabel!
    
    var carparkName = ""
    var carparkID = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carparkNameLabel.text = carparkName
        
        let carParkAPIModels = JSONNull()
        
        //print(carParkAPIModels.carParks("1"))
        
        print(carParkAPIModels.carParks(carparkID))
        
    }


}
