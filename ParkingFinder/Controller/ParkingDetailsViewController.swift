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
    
    var carparkName = ""
    var carparkID = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carparkNameLabel.text = carparkName
        
        let carParkAPIModels = JSONNull()
        
        //print(carParkAPIModels.carParks("1"))
        
        print(carParkAPIModels.carParks(carparkID))
        
        setMapView()
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


}
