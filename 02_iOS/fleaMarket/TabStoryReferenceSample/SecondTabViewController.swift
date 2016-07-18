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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let locationManager = CLLocationManager() // get user's location
    
    var location: CLLocation!
    
    var latitudeArray = [String]()
    var longtitufeArray = [String]()
    var coordinateArray: [CLLocationCoordinate2D] = []
    
    class UserAnnotation: NSObject, MKAnnotation {
        let title: String?
        let locationName: String
        let discipline: String
        let coordinate: CLLocationCoordinate2D
        let userid: Int
        var pinTintColor: MKPinAnnotationColor = MKPinAnnotationColor.Purple
        
        init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, userid: Int, pinTIntColor: UIColor ) {
            self.title = title
            self.locationName = locationName
            self.discipline = discipline
            self.coordinate = coordinate
            self.userid = userid

            super.init()
        }
        
        func getUserId() -> Int {
            return userid
        }
    }
    
    
    @IBAction func resetLocationButton(sender: UIButton) {
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
//        for i in 0...coordinateArray.count-1 {
//            
//        }
        getDataFromDB()
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationIdentifier = "annotation"
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier)
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            view?.canShowCallout = true
            view?.rightCalloutAccessoryView = UIButton(type: .ContactAdd)
        } else {
            view?.annotation = annotation
        }

//        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier) as? MKPinAnnotationView
//        //let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//        let anAnnotation = annotation as! UserAnnotation
//        pinView!.pinColor = anAnnotation.pinTintColor
//        view = pinView
        /*
         let colorPointAnnotation = annotation as! ColorPointAnnotation
         pinView?.pinTintColor = colorPointAnnotation.pinColor
         */
        
        return view
    }
    
    var selectedAnnotation: UserAnnotation!
    var selectedUserId:Int!
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            selectedAnnotation = view.annotation as? UserAnnotation
            //view.annotation.
            //var Id = UserAnnotation.getUserId()
            selectedUserId = selectedAnnotation.userid
            performSegueWithIdentifier("showUser", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? UserDetailViewController {
            destination.userId = selectedUserId
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        map.delegate = self
        
        map.showsUserLocation = true

        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
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
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta:  0.05, longitudeDelta: 0.05)) // zoom the map
        
        self.map.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription) // should it trigger errors, this will put error messages to the debugger
    }
    

    func mapView(mapView: MKMapView!, didAddAnnotationViews views: [MKAnnotationView]!) {
        
        for view in views {
            if view.annotation!.isKindOfClass(MKUserLocation) {
                //view.canShowCallout = false
                view.rightCalloutAccessoryView = nil
            }
        }
        
    }
    
    
    private func getDataFromDB() {
        
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
            ]
        
        //print(methodParameters)
        
        let urlString = Constants.Locations.APIBaseURL + escapedParameters(methodParameters)
        
        print("URL:\(urlString)")
        
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
                    
                    let locationDictionary = parsedResult![Constants.LocationRespondKeys.Locations] as! [[String:AnyObject]]
                    print(locationDictionary)
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    for i in 0...locationDictionary.count-1 {
                        let locLatitude = locationDictionary[i][Constants.LocationRespondKeys.Latitude] as! String
                        let locLongtitude = locationDictionary[i][Constants.LocationRespondKeys.Longtitude] as! String
                        let locName = locationDictionary[i][Constants.LocationRespondKeys.Recipient] as! String
                        let locUserId = locationDictionary[i][Constants.LocationRespondKeys.UserId] as! Int
                        
                        let dobLat = Double(locLatitude)!
                        let dobLong = Double(locLongtitude)!
                        
                        let destination:CLLocationCoordinate2D = CLLocationCoordinate2DMake(dobLat, dobLong)
                        
                        let purple:UIColor = UIColor.purpleColor()
                        let annotation = UserAnnotation(title: locName, locationName: locName, discipline: locName, coordinate: destination, userid: locUserId, pinTIntColor: purple )
                        
                        self.map.addAnnotation(annotation)
                    }
                    //print(priceArray)
                    
                    //print(itemIdArray)
                    
                    //print("3.\(titleArray.count)")
                    
                    performUIUpdatesOnMain(){
                       
                    self.activityIndicator.stopAnimating()
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

