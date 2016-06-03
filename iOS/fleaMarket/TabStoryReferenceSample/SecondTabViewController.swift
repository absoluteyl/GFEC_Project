//
//  SecondViewController.swift
//  TabStoryReferenceSample
//
//  Created by Telieh Lin on 2016/5/28.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager() // get user's location
    
    var location: CLLocation!
    
    @IBAction func resetLocationButton(sender: UIButton) {
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // get locations as accurate as possible
        
        self.locationManager.requestWhenInUseAuthorization() // get locations only when you are using the app
        
        self.locationManager.startUpdatingLocation() // turn on location manager to go look for location
        
        self.map.showsUserLocation = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last // get the last location
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)! , longitude: (location?.coordinate.longitude)!) // center to location
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta:  0.1, longitudeDelta: 0.1)) // zoom the map
        
        self.map.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription) // should it trigger errors, this will put error messages to the debugger
    }
    
    

}

