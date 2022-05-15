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
    var carparkID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carparkNameLabel.text = carparkName
        
    }


}
