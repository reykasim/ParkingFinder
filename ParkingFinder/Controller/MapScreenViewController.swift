//
//  MapScreenViewController.swift
//  ParkingFinder
//
//  Created by Vivian The on 5/5/2022.
//

import Foundation
import UIKit
import MapKit

// let carParkUrl = "https://api.transport.nsw.gov.au/v1/carpark?facility="


class MapScreenViewController: UIViewController {
    
    var address:String?
    
    let carParkModel = CarParkModel()
    
    var carpark = [(ID: String, name: String)]()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var carparkTableView: UITableView!
    @IBOutlet weak var addressLabel: UILabel!
    
    let url = URL(string: carParkUrl + "3")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addressLabel.text = address
        
        carparkTableView.dataSource = self
        carparkTableView.delegate = self
        
        // get carparks from CarParkModel
        carParkModel.requestData {[weak self] (data: [CarParkModels]) in self?.useData (data: data)
        }
        
        let coordinate0 = CLLocation(latitude: 5.0, longitude: 5.0)
        let coordinate1 = CLLocation(latitude: 5.0, longitude: 3.0)
        let distanceInMeters = coordinate0.distance(from: coordinate1)
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
    
    func useData(data: [CarParkModels]) {
        // clear and refresh carpark list
        carpark.removeAll()
        
        // store all carparks from CarParkModel into the tableview
        for info in data {
            carpark.append((ID: info.carParkID, name: info.carParkName))
        }
    }
    
//    func carParks() {
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("apikey fyQ2UwCzxYDSwJRbc58uZkwGoioNfMOs6yVj", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard error == nil else { print(error!.localizedDescription); return }
//            guard let data = data else { print("Empty data"); return }
//
//            if let stra = String(data: data, encoding: .utf8) {
//                print(stra)
//            }
//
//            do{
//                let welcome = try? JSONDecoder().decode(CarParkAPIModel.self, from: data )
//                // welcome
//          //      print(welcome!.zones.count)
//        //        print(welcome!.zones.)
//                // print(welcome?.zoneName)
//                // zones
//
//                for nop in welcome!.zones{
//                    print(nop.spots)
//                }
//
//            } catch let err {
//                print("Err pop", err)
//            }
//
//        }.resume()
//    }
}

extension MapScreenViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carpark.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carparkTableView.dequeueReusableCell(withIdentifier: "carparkCell", for: indexPath)
        
        cell.textLabel?.text = carpark[indexPath.row].name
        
        return cell
    }
    
}

extension MapScreenViewController:UITableViewDelegate {
    
    // selected carpark data transferred to ParkingDetailsViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ParkingDetailsViewController") as? ParkingDetailsViewController {
            vc.carparkName = carpark[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
