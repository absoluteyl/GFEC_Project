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
    
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var tempLatitude:Double!
    var tempLongtitude:Double!
    
    @IBOutlet weak var testLat: UILabel!
    
    @IBOutlet weak var testLong: UILabel!
    
    var initialLocation: CLPlacemark?
    
    @IBOutlet weak var addAddressButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func submitAddressButtonAction(sender: UIButton) {

        if addressTextField.text != "" {
            
            
            var address = "\(addressTextField.text)"
            var geocoder = CLGeocoder()
            
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
                    
                    self.testLat.text =  ("LAT:\(region.center.latitude)")
                    self.testLong.text =  ("LONG:\(region.center.longitude)")

                    region.center.latitude = (placemark.location?.coordinate.latitude)!
                    self.tempLatitude = (placemark.location?.coordinate.latitude)!
                    
                    region.center.longitude = (placemark.location?.coordinate.longitude)!
                    self.tempLongtitude = (placemark.location?.coordinate.longitude)!
                    
                    print(placemark.location?.coordinate.latitude)
                    print(placemark.location?.coordinate.longitude)
                    
                    let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(region.center.latitude, region.center.longitude)

                    region.span = MKCoordinateSpanMake(0.1, 0.1)
                    
                    //self.testLat.text =  ("LAT:\(region.center.latitude)")
                    //self.testLong.text =  ("LONG:\(region.center.longitude)")

                    self.mapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    
                    
                    self.addAddressButton.enabled = true
                }
            })
        }
    }
    
    @IBAction func addAddressButtonAction(sender: UIButton) {
        
        postLocation()
        
        //            addressArray.append(addressTextField.text!)
        //            NSUserDefaults.standardUserDefaults().setObject(addressArray, forKey: "tasks")
        //            navigationController?.popViewControllerAnimated(true)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAddressButton.enabled = false
        
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
    

    func centerMapOnLocation(location: CLLocation)
    {
        
        let regionRadius: CLLocationDistance = 1000
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func postLocation () {
        
        addAddressButton.enabled = false
        
        let methodParameters: [String: String!] = [Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,]
        
        print(methodParameters)
        
        //let url = NSURL(string: Constants.Merchandises.APIBaseURL)!
        let url = NSURL(string: Constants.Locations.APIBaseURL + "/2" + escapedParameters(methodParameters))
        
        
        let request = NSMutableURLRequest(URL: url!)
        
        print(request)
        
        request.HTTPMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //print(self.theDelegate.userID)
        
        //print("64STRING:\(base64String1)")
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var userDefault = NSUserDefaults.standardUserDefaults()
        
        let params:[String: AnyObject] = [
            "location":[
                "user_id" : userDefault.integerForKey("userID"),
                "lat" : Float(tempLatitude),
                "long" : Float(tempLongtitude),
                "address" : addressTextField.text!
                ]
        ]
        
        print(Float(tempLatitude))
        print(Float(tempLongtitude))
        
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
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print(response)
                //print(String(data: data, encoding: NSUTF8StringEncoding))
            } else {
                print(error)
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
