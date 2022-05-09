//
//  MapScreenViewController.swift
//  ParkingFinder
//
//  Created by Vivian The on 5/5/2022.
//

import Foundation
import UIKit

let carParkUrl = "https://api.transport.nsw.gov.au/v1/carpark?facility="


class MapScreenViewController: UIViewController {
    
    var address:String?

    @IBOutlet weak var addressLabel: UILabel!
    
    let url = URL(string: carParkUrl + "3")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addressLabel.text = address
    }
    
    func carParks() {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("apikey fyQ2UwCzxYDSwJRbc58uZkwGoioNfMOs6yVj", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }

            if let stra = String(data: data, encoding: .utf8) {
                print(stra)
            }
            
            do{
                let welcome = try? JSONDecoder().decode(CarParkAPIModel.self, from: data )
                // welcome
        //        print(welcome!.zones.count)
        //        print(welcome!.zones.)
                // print(welcome?.zoneName)
                // zones
                
                for nop in welcome!.zones{
                    print(nop.spots)
                }
                
                
            } catch let err {
                print("Err pop", err)
            }
            
        }.resume()
    }

}
