//
//  ParkingDetailsViewController.swift
//  ParkingFinder
//
//  Created by Vivian The on 5/5/2022.
//

import Foundation


import UIKit
import MapKit

// Call API
let carParkAPIModels = JSONModel()

class ParkingDetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var carParkNameLabel: UILabel!
    @IBOutlet weak var saveCarParkButton: UIButton!
    @IBOutlet weak var carParkSpaceLabel: UILabel!
    @IBOutlet weak var zoneLabel: UIView!
    @IBOutlet weak var zoneCarParkTable: UITableView!
    
    // Varibles definition
    var carParkCoor = ""
    var carParkName = ""
    var carParkID = "1"
    var savedCarPark: [CarParkModels] = []
    var carParkJson: CarParkAPIModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set car park label name
        carParkNameLabel.text = carParkName
        // Setup table view & check if there is data
        if (zoneCarParkTable != nil){
            self.zoneCarParkTable.dataSource = self
        }
        
        // Get specific carpark choosen from previous table
        let carParkinfo = carParkAPIModels.carParks(carParkID)
        
        // Testing data
        print(carParkAPIModels.carParks(carParkID))
        // Set labels
        carParkJson = carParkAPIModels.carParks(carParkID)
        carParkSpaceLabel.text = carParkinfo.spots
        
        // Call map view function
        setMapView()
        
        // the carkpark is already in the saved carkpark array disable button
        if (readSavedCarkParks().filter{$0.carParkID == carParkID}.count > 0){
            saveCarParkButton!.isEnabled = false
        } else{
            saveCarParkButton.isEnabled = true
        }
        // Testing data
        print("list of savedcarpark \(readSavedCarkParks())")
    }
    
    // Set up map to show carpark location
    func setMapView () {
        let carCoor: String = carParkCoor
        let carCoorArray = carCoor.components(separatedBy: ",")
        let location = CLLocationCoordinate2D(latitude: Double(carCoorArray[0])!, longitude: Double(carCoorArray[1])!)
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        let region = MKCoordinateRegion(center: location, span: span)
        
        // Set location of map
        mapView.setRegion(region, animated: true)
        // Set location name
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = carParkName
        mapView.addAnnotation(annotation)
    }
    
    // Set saved carparks in an array
    func setSavedCarPark(){
        self.savedCarPark = readSavedCarkParks()
        savedCarPark.append(CarParkModels(carParkID: carParkID, carParkName: carParkName, carParkCoor: carParkCoor))
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(savedCarPark), forKey: "savedCarPark")
    }
    
    // Get saved carkpark list
    func readSavedCarkParks() -> [CarParkModels] {
        // Gets all players data to read and use
        if let savedArrayData = UserDefaults.standard.value(forKey:"savedCarPark") as? Data {
            if let array = try? PropertyListDecoder().decode(Array<CarParkModels>.self, from: savedArrayData) {
                return array
            } else {
                return []
            }
        } else {
            return []
        }
    }
    
    // let saved car park addresses be called and used in SavedAddressesViewController
    func requestDataHere(completion: ((_ data:[CarParkModels]) -> Void)) {
        let data = readSavedCarkParks()
        completion(data)
    }
    
    // Save cark park button action
    @IBAction func saveCarPark(_ sender: UIButton) {
        // If the button is presses disable the button
        let disableMyButton = sender as? UIButton
        disableMyButton!.isEnabled = false
        
        // Save cark park function
        setSavedCarPark()
    }
}

extension ParkingDetailsViewController: UITableViewDataSource {
    // Getting count of the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carParkJson!.zones.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Linking table to code
        let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCells", for: indexPath)
        // Sets up labels for the table
        let zones = carParkJson!.zones[indexPath.row]
        cell.textLabel?.text = zones.zoneName;
        cell.detailTextLabel?.text = "Current available spots: \(zones.occupancy.total!)";
        
        // Return the cell to HighScoreTableView
        return cell;
        
    }
}
