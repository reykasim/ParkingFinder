//
//  MapScreenViewController.swift
//  ParkingFinder
//
//  Created by Vivian The on 5/5/2022.
//

import Foundation
import UIKit
import MapKit

class MapScreenViewController: UIViewController {
    
    var address:String?
    let carParkModel = CarParkModel()
    var carpark: [CarParkModels] = []

    @IBOutlet weak var carparkTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        carparkTableView.dataSource = self
        carparkTableView.delegate = self
        
        // get carparks from CarParkModel
        carParkModel.requestData {[weak self] (data: [CarParkModels]) in self?.useData (data: data)
        }
        
    }
    
    // gets list of car parks from CarParkModel
    func useData(data: [CarParkModels]) {
        // clear and refresh carpark list
        carpark.removeAll()
        
        // store all carparks from CarParkModel into the tableview
        for info in data {
            carpark.append(CarParkModels(carParkID: info.carParkID, carParkName: info.carParkName, carParkCoor: info.carParkCoor))
        }
    }
    
}

//sets the contents for carpark list table in MapScreenViewController
extension MapScreenViewController:UITableViewDataSource {
    
    // number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carpark.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carparkTableView.dequeueReusableCell(withIdentifier: "carparkCell", for: indexPath)
    // assigns each content for row
        cell.textLabel?.text = carpark[indexPath.row].carParkName
        
        return cell
    }
    
}

extension MapScreenViewController:UITableViewDelegate {
    
    // selected carpark data transferred to ParkingDetailsViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ParkingDetailsViewController") as? ParkingDetailsViewController {
            vc.carParkName = carpark[indexPath.row].carParkName
            vc.carParkID = carpark[indexPath.row].carParkID
            vc.carParkCoor = carpark[indexPath.row].carParkCoor
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
