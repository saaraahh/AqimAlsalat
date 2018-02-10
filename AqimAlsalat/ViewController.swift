//  locationManager.requestAlwaysAuthorization()
//
//  ViewController.swift
//  First
//
//  Created by Dalal Mansour on 2/9/18.
//  Copyright © 2018 Dalal Mansour. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    //constants and variables
    lazy var mapView = GMSMapView()
    var locationManager = CLLocationManager()
    var camera = GMSCameraPosition.camera(withLatitude: 24.725239, longitude: 46.637492, zoom: 13.0)
    var  userLocation = CLLocation()
    let txt =  "we need your location please open the setting and enaible your location"

    //markers locations
    var userLocation1 =  CLLocation(latitude: 24.723561, longitude: 46.622433)
    var userLocation2 =  CLLocation(latitude: 24.713739, longitude: 46.613850)
    var userLocation3 =  CLLocation(latitude: 24.715295, longitude: 46.620974)
    
    //distance
    var distanceInMeters, distanceInMeters1, distanceInMeters2 :Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //user location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        //create priority queue
        
        
        var nodes = PriorityQueue<Mosque>(sort: { $0.priority < $1.priority })
        
        // create distance and nodes
        
        //distance
        let distanceInMeters = userLocation.distance(from: userLocation1)
        let distanceInMeters2 = userLocation.distance(from: userLocation2)
        let distanceInMeters3 = userLocation.distance(from: userLocation3)
        
        
        
        
        //nodes
        let m =  Mosque(priority: distanceInMeters, name: "a",location:(userLocation2), status:"green")
        let  m1 = Mosque(priority: distanceInMeters2, name: "b",location:(userLocation3), status:"orange")
        let m2 = Mosque(priority: distanceInMeters3, name: "c",location:(userLocation1), status:"green")
        
        
        print("11111a:\(distanceInMeters)")
        print("22222b:\(distanceInMeters2)")
        print("333333c:\(distanceInMeters3)")
        
        //peek Node
        var peekNode = Mosque(priority: 1, name: "dalal", location: (userLocation1), status:"grey")
        
        if(m.status != "red")
        {
            nodes.enqueue(element: m)
            nodes.enqueue(element: m1)
            nodes.enqueue(element: m2)
            
            peekNode = nodes.peek()!
            print(" * Node(priority: \(peekNode.priority))"+" * Node(names: \(peekNode.location.altitude))"+" * Node(names: \(peekNode.name))")
            
        }
        else{
            print("reeed")
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last!
        _ = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                          longitude: userLocation.coordinate.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 24.723561, longitude: 46.622433)
        marker.title = "mosque1"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
        let markerSquirt = GMSMarker()
        markerSquirt.position = CLLocationCoordinate2D(latitude: 24.713739, longitude: 46.613850)
        markerSquirt.title = "mosque2"
        markerSquirt.snippet = "Squirtle lives here"
        markerSquirt.map = mapView
        
        let markerSquirt2 = GMSMarker()
        markerSquirt2.position = CLLocationCoordinate2D(latitude: 24.715295, longitude: 46.620974)
        markerSquirt2.title = "mosque3"
        markerSquirt2.snippet = "Squirtle lives here"
        markerSquirt2.map = mapView
        
        
        
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if( status == CLAuthorizationStatus.denied){
            showLocationDisable()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    func showLocationDisable(){
        let alert = UIAlertController(title: "you disable the app", message:txt, preferredStyle: .alert)//preferredStyle can be alert or action sheet *Dalal*
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let open = UIAlertAction(title: "open setting", style: .default) {(action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            }// end of if condition
        }
        alert.addAction(cancel)
        alert.addAction(open)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

