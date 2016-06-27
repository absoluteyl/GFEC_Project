//
//  itemDetailViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/1.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import MapKit

var itemValue:Int!
var itemTitle:String!
var itemDescription:String!
var itemSellerId:Int!
var itemSellerName:String!
var idOfUser:Int!
var userLatitude:Double!
var userLongtitude:Double!

class itemDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
//    @IBOutlet weak var sellerName: UILabel!
//    @IBOutlet weak var itemDescription: UITextView!
//    @IBOutlet weak var itemName: UILabel!
//    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemValueLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UITextView!
    @IBOutlet weak var itemSellerNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var seeUserButton: UIButton!
    @IBAction func seeUserButtonAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("showUserDetail", sender:  seeUserButton)
        
    }
    
    var recentItemId:Int!
    
    @IBOutlet weak var map: MKMapView!

    @IBOutlet weak var sellerImage: UIImageView!
    
    let locationManager = CLLocationManager() // get user's location
    
    var location: CLLocation!
    
    @IBAction func backButton(sender: UIButton) {
        self.performSegueWithIdentifier("goBack", sender: self )
    }

    
    override func viewWillAppear(animated: Bool) {
        getSpecificItem()
    }
    
    override func viewDidLoad() {
        
        itemTitleLabel.hidden = true
        itemDescriptionLabel.hidden = true
        itemValueLabel.hidden = true
        itemSellerNameLabel.hidden = true
        
        super.viewDidLoad()
        
        //getSpecificUser()
        
        print ("\(itemSellerId)")

        
        sellerImage.layer.cornerRadius = sellerImage.frame.size.width/2
        sellerImage.clipsToBounds = true
        
        
        // this is for the map to work but will need to be changed after getting seller location
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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let Destination : UserDetailViewController = segue.destinationViewController as! UserDetailViewController
        //let selectedNumber = sender as! Int
        Destination.userId = itemSellerId
    }
    
    
    private func getSpecificItem() {

        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
            ]
        
        print(methodParameters)
        
        let urlString = Constants.Merchandises.APIBaseURL + "/" + String(recentItemId) + escapedParameters(methodParameters)
    
        
        print("URL:\(urlString)")

        
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        //var itemArray:NSArray?
        
        
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
                    
//                    print(parsedResult)
                    
                    let locationDictionary = parsedResult![Constants.LocationRespondKeys.Location] as? [String:AnyObject]
                    
                    //grab every "title" in dictionaries by look into the array with for loop

                        userLatitude = locationDictionary![Constants.LocationRespondKeys.Latitude] as? Double
                        userLongtitude = locationDictionary![Constants.LocationRespondKeys.Longtitude] as? Double
                    
                    performUIUpdatesOnMain(){
                        
                        // 這裡需要讓地圖向抓到的座標置中
                        
                    }
                    
                    
                }
            }
        }
        task.resume()
    }
    
    
    
    
    private func getSpecificUser() {
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
            ]
        
        //api/users/1?api_key=xxx
        let urlString = Constants.Users.APIBaseURL + "/\(itemSellerId)" + escapedParameters(methodParameters)
        
        
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        //var itemArray:NSArray?
        
        
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
                    
                    print(parsedResult)
                    
                    let itemDictionary = parsedResult![Constants.UsersResponseKeys.User] as? [String:AnyObject]
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    
                    itemSellerName = itemDictionary![Constants.UsersResponseKeys.UserName] as? String
                    
                    guard let imageUrlString = itemDictionary![Constants.UsersResponseKeys.Avatar_M] as? String else {
                        displayError("Cannot find key '\(Constants.UsersResponseKeys.Avatar_M)' in itemDictionary")
                        return
                    }
                    let imageURL = NSURL(string: imageUrlString)
                    if let imageData = NSData(contentsOfURL: imageURL!) {
                        performUIUpdatesOnMain {
                            self.sellerImage.image = UIImage(data: imageData)
                        }
                    } else {
                        displayError("Image does not exist at \(imageURL)")
                    }
                    
                    performUIUpdatesOnMain(){
                        
                        self.itemSellerNameLabel.text = "\(itemSellerName)"
                        self.itemSellerNameLabel.hidden = false
                    }
                }
            }
        }
        task.resume()
    }
    
    private func getUserLocation() {
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.UserID: "\(itemSellerId)",
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key
            ]
        
        //https://ririkoko.herokuapp.com/api/locations?user=7&api_key=e813852b6d35e706f776c74434b001f9
        let urlString = Constants.Locations.APIBaseURL + escapedParameters(methodParameters)
        
        
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        //var itemArray:NSArray?
        
        
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
                    
                    print(parsedResult)
                    
                    let itemDictionary = parsedResult![Constants.UsersResponseKeys.User] as? [String:AnyObject]
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    
                    itemSellerName = itemDictionary![Constants.UsersResponseKeys.UserName] as? String
                    
                    guard let imageUrlString = itemDictionary![Constants.UsersResponseKeys.Avatar_M] as? String else {
                        displayError("Cannot find key '\(Constants.UsersResponseKeys.Avatar_M)' in itemDictionary")
                        return
                    }
                    let imageURL = NSURL(string: imageUrlString)
                    if let imageData = NSData(contentsOfURL: imageURL!) {
                        performUIUpdatesOnMain {
                            self.sellerImage.image = UIImage(data: imageData)
                        }
                    } else {
                        displayError("Image does not exist at \(imageURL)")
                    }
                    
                    performUIUpdatesOnMain(){
                        
                        self.itemSellerNameLabel.text = "\(itemSellerName)"
                        self.itemSellerNameLabel.hidden = false
                    }
                }
            }
        }
        task.resume()
    }
    
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
