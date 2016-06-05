//
//  itemDetailViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/1.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import MapKit

class itemDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!

    @IBOutlet weak var sellerImage: UIImageView!
    
    let locationManager = CLLocationManager() // get user's location
    
    var location: CLLocation!
    
    @IBAction func backButton(sender: UIButton) {
        self.performSegueWithIdentifier("goBack", sender: self )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sellerImage.layer.cornerRadius = sellerImage.frame.size.width/2
        sellerImage.clipsToBounds = true
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // get locations as accurate as possible
        
        self.locationManager.requestWhenInUseAuthorization() // get locations only when you are using the app
        
        self.locationManager.startUpdatingLocation() // turn on location manager to go look for location
        
        self.map.showsUserLocation = true

        // Beggining of adding logo to Navigation Bar
        let logo = UIImage(named: "logo_temp_small.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        // End of adding logo to Navigation Bar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
