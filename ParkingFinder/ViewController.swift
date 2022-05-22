//
//  ViewController.swift
//  ParkingFinder
//
//  Created by Reynard Kasim on 2/5/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMapView" {
            let VC = segue.destination as! MapScreenViewController
            VC.address = addressTextField.text
        }
    }


}

