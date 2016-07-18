//
//  itemDetailViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/1.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import MapKit



class itemDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet weak var sellerName: UILabel!
//    @IBOutlet weak var itemDescription: UITextView!
//    @IBOutlet weak var itemName: UILabel!
//    @IBOutlet weak var itemPrice: UILabel!
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    var recentItemId:Int!
    
    var itemValue:Int!
    var itemTitle:String!
    var itemDescription:String!
    var itemSellerId:Int!
    var itemSellerName:String!
    var idOfUser:Int!
    var itemLocationId:Int!
    var userLatitude:String!
    var userLongtitude:String!
    var statusReply:String!
    let locationManager = CLLocationManager() // get user's location
    var location: CLLocation!
    var deleteAlert = UIAlertController()
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var categoryTemp: String = ""
    var locationTemp: String = ""
    var like_on: UIImage = UIImage(named:"like_on.png")!
    var like_off: UIImage = UIImage(named:"like_off.png")!
    
    @IBOutlet weak var editItemButton: UIButton!
    @IBOutlet weak var deleteItemButton: UIButton!
    
    @IBOutlet weak var itemValueLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
   

    @IBOutlet weak var itemDescriptionText: UITextView!
 
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var itemSellerNameLabel: UILabel!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var seeUserButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    
    @IBOutlet weak var likeButton: UIButton!
    var likeButtonPushed = false

    @IBAction func likeButtonAction(sender: UIButton) {
        if likeButtonPushed == false {
            likeButton.setImage(like_on, forState: .Normal)
            likeButtonPushed = true
        } else {
            likeButton.setImage(like_off, forState: .Normal)
            likeButtonPushed = false
        }
    }
    
    @IBAction func seeUserButtonAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("showUserDetail", sender:  seeUserButton)
        
    }
    
    @IBAction func editItemButtonAction(sender: UIButton) {
        print(itemTitle)
        print(itemValue)
        //appDelegate.itemLocationId = itemLocationId
        self.performSegueWithIdentifier("editItemSegue", sender:  editItemButton)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editItemSegue") {
            let Destination : AddItemInfoTableViewController = segue.destinationViewController as! AddItemInfoTableViewController
            Destination.patchItemTitle = itemTitle
            Destination.patchItemValue = itemValue
            Destination.patchItemDescription = itemDescription
            Destination.patchItemPhoto1 = itemImage.image
            Destination.isPatch = true
            Destination.patchItemId = recentItemId
        } else if (segue.identifier == "showUserDetail") {
            let Destination : UserDetailViewController = segue.destinationViewController as! UserDetailViewController
            //let selectedNumber = sender as! Int
            Destination.userId = itemSellerId
        }
    }
    
    @IBAction func deleteItemButtonActions(sender: UIButton) {
        
        self.deleteAlert = UIAlertController(title: "Do you really want to delete this item?", message: "", preferredStyle: .Alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler:{ (action:UIAlertAction) -> () in
                //print("DELETED")
            self.delete()
            })
        let cancelAction = UIAlertAction(title: "No, keep it",style: .Default, handler: { (action:UIAlertAction) -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(cancelAction)
        
        self.presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.performSegueWithIdentifier("goBack", sender: self )
    }


    
    override func viewWillAppear(animated: Bool) {
        getSpecificItem()
        
    }
    
    override func viewDidLoad() {
        

        
        itemTitleLabel.hidden = true
        itemDescriptionText.hidden = true
        itemValueLabel.hidden = true
        itemSellerNameLabel.hidden = true
        
        super.viewDidLoad()
        
        
        buyButton.layer.cornerRadius = 35/2
        buyButton.backgroundColor = UIColorUtil.rgb(0x654982)
        
        contactButton.layer.cornerRadius = 35/2
        contactButton.backgroundColor = UIColor.clearColor()
        contactButton.layer.borderWidth = 1
        let purple = UIColorUtil.rgb(0x654982)
        contactButton.layer.borderColor = purple.CGColor
        
        
        //getSpecificUser()
        
        print ("itemSeller id = \(itemSellerId)")

        
        sellerImage.layer.cornerRadius = sellerImage.frame.size.width/2
        sellerImage.clipsToBounds = true
        
        
        // this is for the map to work but will need to be changed after getting seller location
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: nil)
        addButton.tintColor = UIColor.clearColor()
        navigationItem.rightBarButtonItem = addButton
        // End of adding logo to Navigation Bar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ItemDetailStatusCell
        
        switch indexPath.row {
        case 0:
            cell.leftLabel.text = "Status"
            cell.rightLabel.text = "90% New"
        case 1:
            cell.leftLabel.text = "Category"
            cell.rightLabel.text = categoryTemp
        case 2:
            cell.leftLabel.text = "Delivery"
            cell.rightLabel.text = "Takkyubin"
        case 3:
            cell.leftLabel.text = "Location"
            cell.rightLabel.text = locationTemp
        default:
            cell.leftLabel.text = "Title"
            cell.rightLabel.text = "Detail"
        }
        
        return cell
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

        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
            ]
        
        //print(methodParameters)
        
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
                    
                   // print(parsedResult)
                    
                    let itemDictionary = parsedResult![Constants.MerchandisesResponseKeys.Merchandise] as? [String:AnyObject]
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    
                    self.itemTitle = itemDictionary![Constants.MerchandisesResponseKeys.MerchandiseTitle] as? String
                    self.itemValue = itemDictionary![Constants.MerchandisesResponseKeys.MerchandisePrice] as? Int
                    self.itemDescription = itemDictionary![Constants.MerchandisesResponseKeys.MerchandiseDescription] as? String
                    self.itemSellerId = itemDictionary![Constants.MerchandisesResponseKeys.UserID] as? Int
                    self.itemLocationId = itemDictionary![Constants.MerchandisesResponseKeys.LocationId] as? Int
                    let categoryNumber = itemDictionary![Constants.MerchandisesResponseKeys.CategoryId] as? Int
                    self.categoryTemp = Dictionaries.CategoryDictionary[categoryNumber!]!
                    
                    guard let imageUrlString = itemDictionary![Constants.MerchandisesResponseKeys.image_1_o] as? String else {
                        displayError("Cannot find key '\(Constants.MerchandisesResponseKeys.image_1_o)' in itemDictionary")
                        return
                    }
                    let imageURL = NSURL(string: imageUrlString)
                    if let imageData = NSData(contentsOfURL: imageURL!) {
                        performUIUpdatesOnMain {
                            self.itemImage.image = UIImage(data: imageData)
                        }
                    } else {
                        displayError("Image does not exist at \(imageURL)")
                    }
                    
                    
                    performUIUpdatesOnMain(){
                        
                        self.itemTitleLabel.text = self.itemTitle
                        self.itemValueLabel.text = "NT$\(self.itemValue)"
                        self.itemDescriptionText.text = self.itemDescription
                        
                        self.itemTitleLabel.hidden = false
                        self.itemDescriptionText.hidden = false
                        self.itemValueLabel.hidden = false
                        
                        self.getSpecificUser()
                        self.getItemLocation()
                        self.tableView.reloadData()

                    }
                }
            }
        }
        task.resume()
    }
    
    
    
    
    
    private func getItemLocation() {
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.Id: "\(itemLocationId)",
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key
            ]
        
        //https://ririkoko.herokuapp.com/api/locations?id=7&api_key=e813852b6d35e706f776c74434b001f9
        let urlString = Constants.Locations.APIBaseURL + escapedParameters(methodParameters)
        
        
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        print(request)
        
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
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    
                    let locationDictionary = parsedResult![Constants.LocationRespondKeys.Locations] as? [[String:AnyObject]]
                    
                    print(locationDictionary)
                    
                    self.userLatitude = locationDictionary![0][Constants.LocationRespondKeys.Latitude] as? String!
                    self.userLongtitude = locationDictionary![0][Constants.LocationRespondKeys.Longtitude] as? String!
                    
                    let latitude: CLLocationDegrees = Double(self.userLatitude)!
                    let longtitude: CLLocationDegrees = Double(self.userLongtitude)!
              
                    var region: MKCoordinateRegion = self.map.region
                   
                    
                    region.center.latitude = latitude
                    region.center.longitude = longtitude
                    
                    let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(region.center.latitude, region.center.longitude)
                    
                    region.span = MKCoordinateSpanMake(0.01, 0.01)
                    
                    performUIUpdatesOnMain(){
                        self.map.setRegion(region, animated: true)
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
                    
                    //                    print(parsedResult)
                    
                    let itemDictionary = parsedResult![Constants.UsersResponseKeys.User] as? [String:AnyObject]
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    
                    self.itemSellerName = itemDictionary![Constants.UsersResponseKeys.UserName] as? String
                    
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
                        
                        self.itemSellerNameLabel.text = "\(self.itemSellerName)"
                        self.itemSellerNameLabel.hidden = false
                        
                        if self.itemSellerId == self.userDefault.integerForKey("userID") {
                            self.editItemButton.hidden = false
                            self.deleteItemButton.hidden = false
                        }
                    }
                }
            }
        }
        task.resume()
    }

    
    
    
    
    private func delete () {
        
        let methodParameters: [String: String!] = [Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,]
        
        print(methodParameters)
        
        let url = NSURL(string: Constants.Merchandises.APIBaseURL + "/\(recentItemId!)" + escapedParameters(methodParameters))
        
        
        let request = NSMutableURLRequest(URL: url!)
        
        print(request)
        
        request.HTTPMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //print(self.theDelegate.userID)
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var userDefault = NSUserDefaults.standardUserDefaults()
        
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
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
            
            if let response = response, data = data {
                print("RESPONSE:\(response)")
                //print(String(data: data, encoding: NSUTF8StringEncoding))
                
                let parsedResult: AnyObject!
                do {
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) //change 16 bit JSON code to redable format
                } catch {
                    displayError("Could not parse the data as JSON: '\(data)'")
                    return
                }
                
                self.statusReply = parsedResult![Constants.UsersResponseKeys.Status] as? String
                
                performUIUpdatesOnMain(){
                    if self.statusReply == "OK" {
                        //self.deleteAlert.dismissWithClickedButtonIndex(-1, animated: true)
                        
                        let alert = UIAlertView()
                        alert.title = "Item Deleted!"
                        alert.message = ""
                        var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
                        loadingIndicator.center = self.view.center;
                        loadingIndicator.hidesWhenStopped = true
                        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                        loadingIndicator.startAnimating();
                        
                        alert.setValue(loadingIndicator, forKey: "accessoryView")
                        loadingIndicator.startAnimating()
                        
                        alert.show()
                        
                        // Delay the dismissal by 5 seconds
                        
                        let seconds = 1.2
                        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                        
                        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                            
                            alert.dismissWithClickedButtonIndex(-1, animated: true)
                            self.navigationController?.popViewControllerAnimated(true)

                        })
                        
                    }
                }
                
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
