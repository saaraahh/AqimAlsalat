//
//  ViewController.swift
//  AqimAlsalat
//
//  Created by ساره عبدالله on ١٣ جما١، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ ساره عبدالله. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController ,CLLocationManagerDelegate{
   let locationManager = CLLocationManager()
    
    
    
    @IBOutlet var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    // sarah 
    
    //implemintation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first
        {
            var userLocation = location.coordinate
            print(userLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if( status == CLAuthorizationStatus.denied){
            //showLocationDisable()
        }
    }
   /* func showLocationDisable(){
        let alertA = UIAlertController(title: "your GPS is turned off", message: "we need your location", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertA.addAction(cancel)
        let openA = UIAlertAction(title: "oopen", style: .default) {(action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertA.addAction(openA)
        self.present(alertA, animated: true, completion: nil)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

