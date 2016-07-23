//
//  AddItemInfoTableViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/11.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit



class AddItemInfoTableViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    var categoryNumber:Int!
    var hasSelectedCategory:Bool = false
    var addressArray = [AddressForm]()
    
    @IBOutlet var StaticTableView: UITableView!
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var imageSelected: UIImage!
    var locationIdSelected: Int!
    
    @IBOutlet weak var tempImageVIew: UIImageView!
    
    @IBOutlet weak var shareSwitch: UISwitch!
    var appDelegate: AppDelegate!
    
    var statusReply:String!
    
    var isPatch:Bool = false
    var patchItemId: Int?
    var patchItemTitle:String?
    var patchItemValue:Int?
    var patchItemDescription:String?
    var patchItemPhoto1:UIImage?
    
    @IBOutlet weak var showLocationLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var addPhoto1: UIButton?
    @IBOutlet weak var addPhoto2: UIButton!
    @IBOutlet weak var addPhoto3: UIButton!
    @IBOutlet weak var statusDetailLabel: UILabel!
    @IBOutlet weak var deliveryDetailLabel: UILabel!
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextField: UITextField!
    @IBOutlet weak var itemAmount: UITextField!
    
    @IBOutlet weak var categoryCell: UITableViewCell!

    let uploadAlert = UIAlertView()
    
    @IBAction func postButtonAction(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        if appDelegate.itemCategoryNumber == -1 {
            let alert = UIAlertController(title: "Oops!", message: "Please select item category before uploading!", preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: {
                (action:UIAlertAction) -> () in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            
            uploadAlert.title = "Uploading"
            uploadAlert.message = "Please wait"
            var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
            loadingIndicator.center = self.view.center;
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loadingIndicator.startAnimating();
            uploadAlert.setValue(loadingIndicator, forKey: "accessoryView")
            loadingIndicator.startAnimating()
            uploadAlert.show()
            
        addPhoto1 = sender
            
            if isPatch == false {
                // if isPatch == false this is posting a new item
                post()
            } else {
                patch()// else it is patching an existing item
            }
        }
        
    }
    @IBOutlet weak var categorySelectedName: UILabel!
    
    @IBAction func addPhoto1Action(sender: UIButton) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {        
        
        guard let addPhoto1 = addPhoto1 else {
            print("Error! action button is nil")
            return
        }
        
        // setting the buuton image to selected image
        let selectedImage = info[UIImagePickerControllerOriginalImage]! as! UIImage
        
        imageSelected = selectedImage
        
        dispatch_async(dispatch_get_main_queue()) {
            
            addPhoto1.setTitle("", forState: .Normal)
            addPhoto1.setImage(selectedImage, forState: .Normal)
        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 1 {
                print("Show category")
                self.performSegueWithIdentifier("showCategory", sender: indexPath.row)
                
            } else if indexPath.row == 0 {
                print("Show Status")
                self.performSegueWithIdentifier("showItemStatus", sender: indexPath.row)
            } else if indexPath.row == 2 {
                print("Show Delivery")
                self.performSegueWithIdentifier("showDelivery", sender: indexPath.row)
            } else if indexPath.row == 3 {
                self.performSegueWithIdentifier("selectAddressSegue", sender: indexPath.row)
            }

        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectAddressSegue" {
            let destination = segue.destinationViewController as! SelectAddressTableViewController
            destination.addressArray = addressArray
        }
    }
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 30))
//
//            headerView.backgroundColor = UIColor.clearColor()
//
//        return headerView
//    }
    
    let sectionHeaderTitleArray = ["Photo","Item Info","Details","Share"]
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 40)) //set these values as necessary
        returnedView.backgroundColor = UIColorUtil.rgb(0xececec)
        
        let label = UILabel(frame: CGRectMake(18, 25, 100, 20))
        label.text = self.sectionHeaderTitleArray[section]
        label.textColor = UIColor.darkGrayColor()
        
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
                let cornerRadius : CGFloat = 9.0
                cell.backgroundColor = UIColor.clearColor()
                var layer: CAShapeLayer = CAShapeLayer()
                var pathRef:CGMutablePathRef = CGPathCreateMutable()
                var bounds: CGRect = CGRectInset(cell.bounds, 10, 0)
                var addLine: Bool = false
                
                if (indexPath.row == 0 && indexPath.row == tableView.numberOfRowsInSection(indexPath.section)-1) {
                    CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius)
                } else if (indexPath.row == 0) {
                    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds))
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius)
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius)
                    CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))
                    addLine = true
                } else if (indexPath.row == tableView.numberOfRowsInSection(indexPath.section)-1) {
                    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds))
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius)
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius)
                    CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds))
                } else {
                    CGPathAddRect(pathRef, nil, bounds)
                    addLine = true
                }
                
                layer.path = pathRef
                layer.fillColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.8).CGColor
                
                if (addLine == true) {
                    var lineLayer: CALayer = CALayer()
                    var lineHeight: CGFloat = (1.0 / UIScreen.mainScreen().scale)
                    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight)
                    lineLayer.backgroundColor = tableView.separatorColor!.CGColor
                    layer.addSublayer(lineLayer)
                }
                var testView: UIView = UIView(frame: bounds)
                testView.layer.insertSublayer(layer, atIndex: 0)
                testView.backgroundColor = UIColor.clearColor()
                cell.backgroundView = testView
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
    }

//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
//    }
//    
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
    override func viewWillAppear(animated: Bool) {

        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.itemCategoryNumber != -1 {
            categorySelectedName.text = Constants.CategoryArrays.CategoryTitleArray[appDelegate.itemCategoryNumber]
        }
        if appDelegate.itemLocationId != -1 {
            locationIdSelected = appDelegate.itemLocationId
            showLocationLabel.text = appDelegate.itemLocationTemp
        }
        if appDelegate.itemStatusNumber != -1 {
            statusDetailLabel.text = Constants.ItemArrays.statusArray[appDelegate.itemStatusNumber]
        }
        
        if appDelegate.itemDeliveryNumber != -1 {
            deliveryDetailLabel.text = Constants.ItemArrays.deliveryArray[appDelegate.itemDeliveryNumber]
        }
        
        tableView.reloadData()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemAmount.delegate = self
        self.itemNameTextField.delegate = self
        self.itemPriceTextField.delegate = self
        self.itemDescriptionTextField.delegate = self
        self.itemAmount.returnKeyType = UIReturnKeyType.Done
        self.itemNameTextField.returnKeyType = UIReturnKeyType.Done
        self.itemPriceTextField.returnKeyType = UIReturnKeyType.Done
        self.itemDescriptionTextField.returnKeyType = UIReturnKeyType.Done
        
        
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        getLocationFromDB()
        tableView.backgroundColor = UIColorUtil.rgb(0xececec)
        postButton.backgroundColor = UIColor.clearColor()
        postButton.layer.cornerRadius = 20
        postButton.backgroundColor = UIColorUtil.rgb(0x654982)
        shareSwitch.on = false
        
        let onColor  = UIColorUtil.rgb(0x5EC3B3)
        let offColor = UIColorUtil.rgb(0xececec)
        
        /*For on state*/
        shareSwitch.onTintColor = onColor
        
        /*For off state*/
        shareSwitch.tintColor = offColor
        shareSwitch.layer.cornerRadius = 16
        shareSwitch.backgroundColor = offColor

        
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
        
//        self.hideKeyboardWhenTappedAround() 
        
        // for testing
//        itemNameTextField.text = "Pudding"
//        itemDescriptionTextField.text = "This is a pudding I made. It's very good."
//        itemAmount.text = "1"
//        itemPriceTextField.text = "100"
        
        if isPatch == true {
            itemNameTextField.text = patchItemTitle
            itemDescriptionTextField.text = patchItemDescription
            itemPriceTextField.text = String(patchItemValue!)
            addPhoto1!.setTitle("", forState: .Normal)
            addPhoto1!.setImage(patchItemPhoto1, forState: .Normal)
            imageSelected = patchItemPhoto1
        }

        self.addPhoto1!.setTitle("", forState: .Normal)
        self.addPhoto1!.setImage(imageSelected!, forState: .Normal)
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
//        itemAmount.text = ""
//        itemNameTextField.text = ""
//        itemPriceTextField.text = ""
//        itemDescriptionTextField.text = ""
//        
    }
    
    
    private func getLocationFromDB() {
        
        var userDefault = NSUserDefaults.standardUserDefaults()
        
        //http://ririkoko.herokuapp.com/api/locations?user=1&api_key=e813852b6d35e706f776c74434b001f9
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
            Constants.ParameterKeys.User: String(userDefault.integerForKey("userID"))
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
                        
                        let tempLocation = AddressForm()
                        
                        tempLocation.id = locationDictionary[i][Constants.LocationRespondKeys.Id] as! Int
                        let cityArray = locationDictionary[i][Constants.LocationRespondKeys.City] as! [String:AnyObject]
                        tempLocation.city_id = cityArray[Constants.LocationRespondKeys.ParentId] as! Int
                        tempLocation.name = locationDictionary[i][Constants.LocationRespondKeys.Alias] as! String
                        tempLocation.address = locationDictionary[i][Constants.LocationRespondKeys.Address] as! String
                        tempLocation.postCode = cityArray[Constants.LocationRespondKeys.PostCode] as! String
                        self.addressArray.append(tempLocation)

                    }
                    print(self.addressArray[0].city_id)
                    print(Constants.CityArrays.CityNameArray[self.addressArray[0].city_id])
                    print(self.addressArray[0].name)
                    print(self.addressArray[0].address)
                    performUIUpdatesOnMain(){
                        self.showLocationLabel.text = self.addressArray[0].postCode + Constants.CityArrays.CityNameArray[self.addressArray[0].city_id-1] + self.addressArray[0].name + "區" + self.addressArray[0].address
                        self.locationIdSelected = self.addressArray[0].id
                        
                    }
                }
            }
        }
        task.resume()
    }


    private func post () {
        
        postButton.enabled = false
        
        let methodParameters: [String: String!] = [Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,]
        
        print(methodParameters)
        
        let url = NSURL(string: Constants.Merchandises.APIBaseURL + escapedParameters(methodParameters))
        
        
        let request = NSMutableURLRequest(URL: url!)
        
        print(request)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //print(self.theDelegate.userID)
        
        var imageT : UIImage = (imageSelected)!
        
        var imageData1 = UIImageJPEGRepresentation(imageT, 1.0)
        
        var base64String1 = imageData1!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        //print("64STRING:\(base64String1)")
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       
        var userDefault = NSUserDefaults.standardUserDefaults()
        
        let params:[String: AnyObject] = [
            "merchandise":[
                "title" : itemNameTextField.text!,
                "description" : itemDescriptionTextField.text!,
                "price" : itemPriceTextField.text!,
                "amount" : itemAmount.text!,
                "user_id" : userDefault.integerForKey("userID"),
                "category_id" : Constants.CategoryArrays.CategoryIdArray[appDelegate.itemCategoryNumber],
                "image_1" : "data:image/jpeg;base64,\(base64String1)",
                "location_id" : locationIdSelected
            ],
        ]
        
        print("CATEGORY ARRAY NO.:\(appDelegate.itemCategoryNumber)")
        print("CATEGORY DB NO.:\(Constants.CategoryArrays.CategoryIdArray[appDelegate.itemCategoryNumber])")
        
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
                    
                        performUIUpdatesOnMain(){
                            self.uploadAlert.dismissWithClickedButtonIndex(-1, animated: true)
                            let alert = UIAlertView()
                            alert.title = "Oops!!"
                            alert.message = "error occured"
                            var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
                            
                            
                            alert.show()
                            
                            // Delay the dismissal by 5 seconds
                            
                            let seconds = 1.2
                            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                            
                            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                                
                                alert.dismissWithClickedButtonIndex(-1, animated: true)
                                self.postButton.enabled = true
                            })
                        }
                
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
                        self.uploadAlert.dismissWithClickedButtonIndex(-1, animated: true)
                        let alert = UIAlertView()
                        alert.title = "Upload Success!"
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
                            self.tabBarController?.selectedIndex = 0
                            self.postButton.enabled = true
                        })}
                    
                    appDelegate.itemStatusNumber = -1
                    appDelegate.itemLocationTemp = ""
                    appDelegate.itemLocationId = -1
                    appDelegate.itemDeliveryNumber = -1
                    appDelegate.itemStatusNumber = -1
                    
                    self.itemAmount.text = ""
                    self.itemNameTextField.text = ""
                    self.itemPriceTextField.text = ""
                    self.itemDescriptionTextField.text = ""
                    
                    
                }
                
                self.navigationController?.popViewControllerAnimated(true)
                
            } else {
                print(error)
            }
            
        }
        
        task.resume()
        
    
    }
    
    private func patch () {
        
        postButton.enabled = false
        
        let methodParameters: [String: String!] = [Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,]
        
        print(methodParameters)
        
        let url = NSURL(string: Constants.Merchandises.APIBaseURL + "/\(patchItemId!)" + escapedParameters(methodParameters))
        
        
        let request = NSMutableURLRequest(URL: url!)
        
        print(request)
        
        request.HTTPMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //print(self.theDelegate.userID)
        
        var imageT : UIImage = (imageSelected)!
        
        var imageData1 = UIImageJPEGRepresentation(imageT, 1.0)
        
        var base64String1 = imageData1!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        //print("64STRING:\(base64String1)")
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var userDefault = NSUserDefaults.standardUserDefaults()
        
        let params:[String: AnyObject] = [
            "merchandise":[
                "title" : itemNameTextField.text!,
                "description" : itemDescriptionTextField.text!,
                "price" : itemPriceTextField.text!,
                "amount" : itemAmount.text!,
                "user_id" : userDefault.integerForKey("userID"),
                "category_id" : Constants.CategoryArrays.CategoryIdArray[appDelegate.itemCategoryNumber],
                "image_1" : "data:image/jpeg;base64,\(base64String1)",
                "location_id" : locationIdSelected
             ],
            ]
        
        print("CATEGORY ARRAY NO.:\(appDelegate.itemCategoryNumber)")
        print("CATEGORY DB NO.:\(Constants.CategoryArrays.CategoryIdArray[appDelegate.itemCategoryNumber])")
        
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
                        self.uploadAlert.dismissWithClickedButtonIndex(-1, animated: true)
                        let alert = UIAlertView()
                        alert.title = "Upload Sucess!"
                        alert.message = ""
                        var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
                        loadingIndicator.center = self.view.center;
                        loadingIndicator.hidesWhenStopped = true
                        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                        loadingIndicator.startAnimating()
                        
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
                            self.postButton.enabled = true
                            
                        })
                        
                        self.isPatch = false
                        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.itemStatusNumber = -1
                        appDelegate.itemLocationTemp = ""
                        appDelegate.itemLocationId = -1
                        appDelegate.itemDeliveryNumber = -1
                        appDelegate.itemStatusNumber = -1
                        
                        self.itemAmount.text = ""
                        self.itemNameTextField.text = ""
                        self.itemPriceTextField.text = ""
                        self.itemDescriptionTextField.text = ""
                        
                        
                    }
                    
                    self.navigationController?.popViewControllerAnimated(true)
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
