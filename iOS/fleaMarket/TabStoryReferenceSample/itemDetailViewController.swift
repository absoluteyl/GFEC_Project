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
    
    @IBOutlet weak var testLabel: UILabel!
    var recentItemId:Int!
    
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
        
        testLabel.text = String(recentItemId!)
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

    
    
    
    private func getSpecificItem() {
        
        let urlString = "https://flea-market-kyujyo.c9users.io/api/merchandises"
        //let urlString = Constants.Merchandises.APIBaseURL
        //let urlString = "https://flea-market-absoluteyl.c9users.io/api/merchandises"
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        var itemArray:NSArray?
        
        
        // if an error occur, print it
        func displayError(error: String) {
            print(error)
            print("URL at time of error: \(url)")
            
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            if error == nil {
                if let data = data {
                    let parsedResult: AnyObject!
                    do {
                        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) //change 16 bit JSON code to redable format
                    } catch {
                        displayError("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    
                    //print(parsedResult)
                    
                    let itemDictionary = parsedResult as? [[String:AnyObject]]
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    for i in 0...itemDictionary!.count-1 {
                        let itemTitle = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseTitle] as? String
                        //print (itemTitle!)
                        let itemPrice = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandisePrice] as? Int
                        let itemId = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseId] as? Int
                        
                        
                        priceArray.append(itemPrice!)
                        titleArray.append(itemTitle!)
                        itemIdArray.append(itemId!)
                        
                    }
                    print(priceArray)
                    print(titleArray)
                    print(itemIdArray)
                    
                    print("3.\(titleArray.count)")
                    
                    performUIUpdatesOnMain(){
                        self.collectionView.reloadData()
                    }
                    
                    
                }
            }
        }
        
        task.resume()
        
    }

}
