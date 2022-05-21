//
//  ParkingDetailsViewController.swift
//  ParkingFinder
//
//  Created by Vivian The on 5/5/2022.
//

import Foundation


import UIKit
import MapKit

class ParkingDetailsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var carparkNameLabel: UILabel!
    @IBOutlet weak var saveCarkParkButton: UIButton!
    
    var carParkCoor = ""
    var carparkName = ""
    var carparkID = "1"
    var savedCarPark: [CarParkModels] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carparkNameLabel.text = carparkName
        
        let carParkAPIModels = JSONNull()
        
        //print(carParkAPIModels.carParks("1"))
        
        print(carParkAPIModels.carParks(carparkID))
        
        setMapView()
        
        if (readHighScores().filter{$0.carParkID == carparkID}.count > 0){
            saveCarkParkButton!.isEnabled = false
        } else{
            saveCarkParkButton.isEnabled = true
        }
    }
    
    func setMapView () {
        let location = CLLocationCoordinate2D(latitude: -33.69163, longitude: 150.906022)
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
                
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Tallawong Station Car Park"
        mapView.addAnnotation(annotation)
    }
    
    func setSavedCarPark(){
        self.savedCarPark = readHighScores()
        savedCarPark.append(CarParkModels(carParkID: carparkID, carParkName: carparkName, carParkCoor: carParkCoor))
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(savedCarPark), forKey: "savedCarPark")
        
        print(readHighScores())
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
