//
//  ParkingDetailsViewController.swift
//  ParkingFinder
//
//  Created by Vivian The on 5/5/2022.
//

import Foundation


import UIKit
import MapKit

let carParkAPIModels = JSONNull()


class ParkingDetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var carparkNameLabel: UILabel!
    @IBOutlet weak var saveCarkParkButton: UIButton!
    @IBOutlet weak var carParkSpaceLabel: UILabel!
    @IBOutlet weak var zoneLabel: UIView!
    //@IBOutlet weak var zoneTable: UITableViewCell!
    @IBOutlet weak var zoneCarParkTable: UITableView!
    
    var carParkCoor = ""
    var carparkName = ""
    var carparkID = "1"
    var savedCarPark: [CarParkModels] = []
    var Jsoncar: CarParkAPIModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carparkNameLabel.text = carparkName
        if (zoneCarParkTable != nil){
            //self.zoneCarParkTable.delegate = self
            self.zoneCarParkTable.dataSource = self
        }
        
        // let carParkAPIModels = JSONNull()
        
        //print(carParkAPIModels.carParks("1"))
        let JSONCarPark = carParkAPIModels.carParks(carparkID)
        print(carParkAPIModels.carParks(carparkID))
        // let JSONCarPark = carParkAPIModels.carParks(carparkID)
        Jsoncar = carParkAPIModels.carParks(carparkID)
        carParkSpaceLabel.text = JSONCarPark.spots
        
        
        setMapView()
        
        if (readHighScores().filter{$0.carParkID == carparkID}.count > 0){
            saveCarkParkButton!.isEnabled = false
        } else{
            saveCarkParkButton.isEnabled = true
        }
        
        print("list of savedcarpark \(readHighScores())")
    }
    
    func setMapView () {
        var carCoor: String = carParkCoor
        var carCoorArray = carCoor.components(separatedBy: ",")
        let location = CLLocationCoordinate2D(latitude: Double(carCoorArray[0])!, longitude: Double(carCoorArray[1])!)
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
                
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = carparkName
        mapView.addAnnotation(annotation)
    }
    
    func setSavedCarPark(){
        self.savedCarPark = readHighScores()
        savedCarPark.append(CarParkModels(carParkID: carparkID, carParkName: carparkName, carParkCoor: carParkCoor))
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(savedCarPark), forKey: "savedCarPark")
    }
    
    func readHighScores() -> [CarParkModels] {
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
        let data = readHighScores()
        completion(data)
    }
    
    @IBAction func saveCarPark(_ sender: UIButton) {
        let disableMyButton = sender as? UIButton
        disableMyButton!.isEnabled = false
        
        setSavedCarPark()
//        if (readHighScores().filter{$0.carParkID == carparkID}.count > 0){
//            let disableMyButton = sender as? UIButton
//            disableMyButton!.isEnabled = false
//        } else{
//
//        }
    }
}

extension ParkingDetailsViewController: UITableViewDataSource {
    // Getting count of the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // let carParkAPIModels = JSONNull()
        
        return Jsoncar!.zones.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Linking table to code
        let cell = tableView.dequeueReusableCell(withIdentifier: "zoneCells", for: indexPath)
        // Sets up labels for the table
        let zones = Jsoncar!.zones[indexPath.row]
        cell.textLabel?.text = zones.zoneName;
        cell.detailTextLabel?.text = "Current available spots: \(zones.occupancy.total!)";
        
        // Return the cell to HighScoreTableView
        return cell;
        
    }
}
