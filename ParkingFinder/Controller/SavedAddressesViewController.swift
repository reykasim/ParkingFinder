//
//  SavedAddressesViewController.swift
//  ParkingFinder
//
//  Created by Vivian The on 5/5/2022.
//

import Foundation


import UIKit

// array to hold all saved carparks
var savedData: [CarParkModels] = []


class SavedAddressesViewController: UIViewController {

    let parkingDetailsViewController = ParkingDetailsViewController()

    @IBOutlet weak var SavedAddressesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SavedAddressesTableViewCell", bundle: nil)
        SavedAddressesTableView.register(nib, forCellReuseIdentifier: "SavedAddressesTableViewCell")
        SavedAddressesTableView.dataSource = self
        SavedAddressesTableView.delegate = self
        
        // get saved addresses from ParkingDetailsViewController
        parkingDetailsViewController.requestDataHere {[weak self] (data: [CarParkModels]) in self?.useInfo(data: data) }
        
    }
    
    func useInfo(data: [CarParkModels]) {
        // clear and refresh saved addresses list
        savedData.removeAll()
        
        // store all addresses from parkingDetailsViewController into tableview
        for info in data {
            savedData.append(CarParkModels(carParkID: info.carParkID, carParkName: info.carParkName, carParkCoor: info.carParkCoor))
        }
        
    }
    
}

extension SavedAddressesViewController:UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SavedAddressesTableView.dequeueReusableCell(withIdentifier: "SavedAddressesTableViewCell", for: indexPath) as! SavedAddressesTableViewCell
        
        cell.carparkName.text = savedData[indexPath.row].carParkName
        cell.carparkCor.text = savedData[indexPath.row].carParkCoor
        
        return cell
    }
    
    
}

extension SavedAddressesViewController:UITableViewDelegate {
    
    // selected carpark data transferred to ParkingDetailsViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ParkingDetailsViewController") as? ParkingDetailsViewController {
           
            vc.carparkName = savedData[indexPath.row].carParkName
            vc.carparkID = savedData[indexPath.row].carParkID
            vc.carParkCoor = savedData[indexPath.row].carParkCoor
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
