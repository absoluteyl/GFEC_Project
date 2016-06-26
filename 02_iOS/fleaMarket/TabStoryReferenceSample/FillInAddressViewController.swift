//
//  FillInAddressViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/18.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import MapKit

class FillInAddressViewController: UIViewController {
    
    var initialLocation: CLPlacemark?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func submitAddressButtonAction(sender: UIButton) {

        if addressTextField.text != "" {
            
            
            var address = "\(addressTextField.text)"
            var geocoder = CLGeocoder()
//            geocoder.geocodeAddressString(address, completionHandler: CLGeocodeCompletionHandler)
            
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                
                guard error == nil else{
                    print("Error! geocodeAddressString error=\(error)")
                    return
                }
                
                guard let marks = placemarks else{
                    print("Error! geocodeAddressString placemark is nil.")
                    return
                }
                
                if placemarks != nil && placemarks!.count > 0{
                    let placemark = placemarks![0] as CLPlacemark
                    //placemark.location.coordinate 取得經緯度的參數
                    var region: MKCoordinateRegion = self.mapView.region

                    region.center.latitude = (placemark.location?.coordinate.latitude)!
                    region.center.longitude = (placemark.location?.coordinate.longitude)!
                    
                    print(placemark.location?.coordinate.latitude)
                    print(placemark.location?.coordinate.longitude)

                    region.span = MKCoordinateSpanMake(0.5, 0.5)

                    self.mapView.setRegion(region, animated: true)
                    
                }
            })
           
           
//            addressArray.append(addressTextField.text!)
//            NSUserDefaults.standardUserDefaults().setObject(addressArray, forKey: "tasks")
//            navigationController?.popViewControllerAnimated(true)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func centerMapOnLocation(location: CLLocation)
    {
        
        let regionRadius: CLLocationDistance = 1000
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    

}
