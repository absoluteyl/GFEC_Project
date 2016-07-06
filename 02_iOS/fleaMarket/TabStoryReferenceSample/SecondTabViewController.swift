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
    @IBOutlet weak var homeButton: UIButton!
    
    let locationManager = CLLocationManager() // get user's location
    
    var location: CLLocation!
    
    
    @IBAction func resetLocationButton(sender: UIButton) {
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Beggining of adding logo to Navigation Bar
        let logo = UIImage(named: "logo_temp_small.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        // End of adding logo to Navigation Bar
        
        homeButton.layer.cornerRadius = homeButton.frame.size.width/2
        homeButton.clipsToBounds = true //make home button round
        
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
    
    
    
//    private func getDataFromDB() {
//        
//        
//        let methodParameters: [String: String!] = [
//            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
//            ]
//        
//        //print(methodParameters)
//        
//        let urlString = Constants.Merchandises.APIBaseURL + escapedParameters(methodParameters)
//        
//        print("URL:\(urlString)")
//        
//        let url = NSURL(string: urlString)!
//        let request = NSURLRequest(URL: url)
//        var itemArray:NSArray?
//        
//        
//        // if an error occur, print it
//        func displayError(error: String) {
//            print(error)
//            print("URL at time of error: \(url)")
//            
//        }
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
//            
//            if error == nil {
//                if let data = data {
//                    let parsedResult: AnyObject!
//                    do {
//                        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) //change 16 bit JSON code to redable format
//                    } catch {
//                        displayError("Could not parse the data as JSON: '\(data)'")
//                        return
//                    }
//                    
//                    //print(parsedResult)
//                    
//                    let itemDictionary = parsedResult![Constants.MerchandisesResponseKeys.Merchandises] as? [[String:AnyObject]]
//                    
//                    
//                    //grab every "title" in dictionaries by look into the array with for loop
//                    for i in 0...itemDictionary!.count-1 {
//                        let itemTitle = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseTitle] as? String
//                        //print (itemTitle!)
//                        let itemPrice = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandisePrice] as? Int
//                        let itemId = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseId] as? Int
//                        let itemImage = itemDictionary![i][Constants.MerchandisesResponseKeys.image_1_s] as? String
//                        
//                        
//                        priceArray.append(itemPrice!)
//                        titleArray.append(itemTitle!)
//                        itemIdArray.append(itemId!)
//                        imageArray.append(itemImage!)
//                        
//                    }
//                    //print(priceArray)
//                    //print(titleArray)
//                    //print(itemIdArray)
//                    
//                    //print("3.\(titleArray.count)")
//                    
//                    performUIUpdatesOnMain(){
//                        self.collectionView.reloadData()
//                        self.activityIndicator.stopAnimating()
//                    }
//                }
//            }
//        }
//        task.resume()
//    }
    
    func escapedParameters(parameters: [String:AnyObject]) -> String {
        if parameters.isEmpty {
            return ""
        } else {
            var keyValurPairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure it is a string value (convert the ones aren't)
                let stringValue = "\(value)"
                
                //escape it
                let escapeValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) //convert string to ASCII compliant version of a string, returns characters considered safe ASCIIs only
                
                //append it
                keyValurPairs.append(key + "=" + "\(escapeValue!)")
                
            }
            return "?\(keyValurPairs.joinWithSeparator("&"))"
        }
        
    }
    

}

