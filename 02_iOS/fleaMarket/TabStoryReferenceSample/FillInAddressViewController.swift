//
//  FillInAddressViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/18.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import MapKit

class FillInAddressViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let CityTableViewController = CityTable()
    let AreaTableViewController = AreaTable()
    
    
    
    var tempLatitude:Double!
    var tempLongtitude:Double!
    
    var selecedIdForArea:Int?
    
    @IBOutlet weak var testLat: UILabel!
    
    @IBOutlet weak var testLong: UILabel!
    
    var initialLocation: CLPlacemark?
    
    @IBOutlet weak var addAddressButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var chooseCityButton: UIButton!
    
    @IBOutlet weak var chooseAreaButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBAction func chooseCityButtonAction(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "CityTable", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("CityTable") as! CityTable
        
        vc.preferredContentSize = CGSize(width: 200, height: 200)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .Popover
        navController.navigationBarHidden = true
        let popMenu = navController.popoverPresentationController
        popMenu?.delegate = self
        let viewForSource = sender as! UIView
        popMenu?.sourceView = viewForSource
        popMenu?.sourceRect = viewForSource.bounds
        
        presentViewController(navController, animated: true, completion: nil)
    }
    
    @IBAction func chooseAreaButtonAction(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "AreaTable", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AreaTable") as! AreaTable
        
        vc.preferredContentSize = CGSize(width: 200, height: 200)
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .Popover
        navController.navigationBarHidden = true
        vc.selectedCityId = selecedIdForArea
        
        let popMenu = navController.popoverPresentationController
        popMenu?.delegate = self
        let viewForSource = sender as! UIView
        popMenu?.sourceView = viewForSource
        popMenu?.sourceRect = viewForSource.bounds
        
        presentViewController(navController, animated: true, completion: nil)
    }

    
    func addObservers(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FillInAddressViewController.menu(_:)), name: menuTappedDone, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FillInAddressViewController.menu1(_:)), name: menuTappedDone1, object: nil)
    }
    
    func menu(sender: NSNotificationCenter){
        chooseCityButton.setTitle(Constants.CityArrays.CityNameArray[selectedNumber] + "  ▿", forState: .Normal)
        chooseAreaButton.setTitle(PostalDictionay.PostalArrayOfTuples[selectedNumber][0].1 + "  ▿", forState: .Normal)
        selecedIdForArea = selectedNumber
        print(selectedNumber)
        print(selecedIdForArea)
    }
    
    func menu1(sender: NSNotificationCenter){
        chooseAreaButton.setTitle(PostalDictionay.PostalArrayOfTuples[selectedNumber][selectedAreaNumber].1 + "  ▿", forState: .Normal)
        selecedIdForArea = selectedAreaNumber
        print(selectedNumber)
        print(selecedIdForArea)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
    @IBAction func submitAddressButtonAction(sender: UIButton) {

        if addressTextField.text != "" {
            
            
            var address = Constants.CityArrays.CityNameArray[selectedNumber] + PostalDictionay.PostalArrayOfTuples[selectedNumber][selectedAreaNumber].1 + "\(addressTextField.text)"
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
                    
                    self.addAddressButton.backgroundColor = UIColorUtil.rgb(0x654982)
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
    
    override func viewWillAppear(animated: Bool) {
        if theDelegate.cityTemp != -1{
            chooseCityButton.setTitle(Constants.CityArrays.CityNameArray[theDelegate.cityTemp] + "  ▿", forState: .Normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        

        self.addressTextField.delegate = self
        self.addressTextField.returnKeyType = UIReturnKeyType.Done

        
        addAddressButton.backgroundColor = UIColorUtil.rgb(0xB3A8BF)
        addAddressButton.layer.cornerRadius = 6
        
        addAddressButton.enabled = false
    
        let purple = UIColorUtil.rgb(0x654982)
        
        chooseCityButton.layer.cornerRadius = 6
        chooseCityButton.backgroundColor = UIColor.clearColor()
        chooseCityButton.layer.borderColor = purple.CGColor
        chooseCityButton.layer.borderWidth = 1
        
        chooseAreaButton.layer.cornerRadius = 6
        chooseAreaButton.backgroundColor = UIColor.clearColor()
        chooseAreaButton.layer.borderColor = purple.CGColor
        chooseAreaButton.layer.borderWidth = 1
        
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = purple.CGColor
        searchButton.layer.cornerRadius = 20
        
        addAddressButton.layer.cornerRadius = 17.5
        
        CityTableViewController.modalPresentationStyle = .Popover
        CityTableViewController.preferredContentSize = CGSizeMake(50, 100)
        
        AreaTableViewController.modalPresentationStyle = .Popover
        AreaTableViewController.preferredContentSize = CGSizeMake(50, 100)
        
        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: nil)
        addButton.tintColor = UIColor.clearColor()
        navigationItem.rightBarButtonItem = addButton
        // End of adding logo to Navigation Bar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
        let url = NSURL(string: Constants.Locations.APIBaseURL  + escapedParameters(methodParameters))
        
        
        let request = NSMutableURLRequest(URL: url!)
        
        print(request)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //print(self.theDelegate.userID)
        
        //print("64STRING:\(base64String1)")
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var userDefault = NSUserDefaults.standardUserDefaults()
        
        let postCode:Int = PostalDictionay.PostalArrayOfTuples[selectedNumber][selectedAreaNumber].0
        let alias:String  = PostalDictionay.PostalArrayOfTuples[selectedNumber][selectedAreaNumber].1
        let city_id:Int = PostalDictionay.PostalArrayOfTuples[selectedNumber][selectedAreaNumber].2

        
        print("postcode:\(postCode)")
        
        let params:[String: AnyObject] = [
            "location":[
                "user_id" : userDefault.integerForKey("userID"),
                "lat" : Float(tempLatitude),
                "long" : Float(tempLongtitude),
                "address" : addressTextField.text!,
                "postcode" : postCode ,
                "city_id" : city_id ,
                "alias" : alias ,
                "recipient" : "\(userDefault.objectForKey("userName")!)",
                "phone" : "0000000000",
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
                
                    performUIUpdatesOnMain({ 
                        self.navigationController?.popViewControllerAnimated(true)
                    })
            
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
