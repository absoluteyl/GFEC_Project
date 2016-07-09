//
//  FifthTabViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/3.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import MapKit

class FifthTabViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    @IBAction func loginButton(sender: UIButton) {
        
    }
    
    @IBAction func logoutButtonActions(sender: UIButton) {
        navigationController?.popToRootViewControllerAnimated(true)
        logout()
    }
    
    @IBAction func EditProfileButton(sender: UIButton) {
    }
    
    @IBAction func button01_Address(sender: UIButton) {
        
      //  performSegueWithIdentifier("S01_Segue", sender: nil)
    }
    
    @IBAction func button02_Account(sender: UIButton) {
    }
    
    @IBAction func button03_Settings(sender: UIButton) {
    }
    
    @IBAction func button04_Favorites(sender: UIButton) {
    }
    
    @IBAction func button05_MySell(sender: UIButton) {
    }
    
    @IBAction func button06_Records(sender: UIButton) {
    }
    
    @IBAction func button07_QnA(sender: UIButton) {
    }
    
    @IBAction func button08_About(sender: UIButton) {
    }
    
    @IBAction func button09_ContactSupport(sender: UIButton) {
    }
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager() // get user's location
    
    var location: CLLocation!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // get locations as accurate as possible
        
        self.locationManager.requestWhenInUseAuthorization() // get locations only when you are using the app
        
        self.locationManager.startUpdatingLocation() // turn on location manager to go look for location
        
        self.map.showsUserLocation = true
        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        // End of adding logo to Navigation Bar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ReLoggingIn" {
            let Destination : LoginViewController = segue.destinationViewController as! LoginViewController
            Destination.isReLoggingIn = true
        }
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
    

    private func logout() {
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key
        ]
        
        //print(methodParameters)
        
        let urlString = Constants.Users.APIBaseURL_logout + escapedParameters(methodParameters)
        
        //print(urlString)
        
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var email = userDefault.objectForKey("userEmail")!
        
        let params:[String: AnyObject] = [
            "user_login":[
                "email": "\(email)",
            ]
        ]
        
        
        
        do{
            if NSJSONSerialization.isValidJSONObject(params) {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options:.PrettyPrinted)
            }else{
                print("Not Valid")
            }
            
        }catch {
            print("Error!  dataWithJSONObject \(error)")
            return
        }
        
        func displayError(error: String) {
            print(error)
            print("URL at time of error: \(url)")
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(error: String) {
                print(error)
                print("URL at time of error: \(url)")
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            print(response)
            
            if error == nil {
                if let data = data {
                    
                    let parsedResult: AnyObject!
                    do {
                        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) //change 16 bit JSON code to redable format
                    } catch {
                        displayError("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    
                    let statusReply = parsedResult![Constants.UsersResponseKeys.Status] as? String
                    
                    
                    print(parsedResult)
                    
                    /*
                     {"status":"OK","message":"You're successfully signed in.","id":1,"email":"chinbo@gmail.com","authentication_token":"RxxXWabraXoVTA5Cz5rQ"}
                     */
                    
                    self.userDefault.setInteger(-1, forKey: "userID")
                    
                    if statusReply! == "OK" {
                        performUIUpdatesOnMain(){
                            
                            var userDefault = NSUserDefaults.standardUserDefaults()
                            
                            userDefault.setBool(false, forKey: "hasLoggedIn")
                            self.navigationController?.popViewControllerAnimated(true)
                            self.performSegueWithIdentifier("logoutSegue", sender: self)
                        }
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
