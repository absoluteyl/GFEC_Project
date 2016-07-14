//
//  AddItemInfoTableViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/11.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit



class AddItemInfoTableViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var categoryNumber:Int!
    var hasSelectedCategory:Bool = false
    
    @IBOutlet var StaticTableView: UITableView!
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var imageSelected: UIImage!
    
    @IBOutlet weak var tempImageVIew: UIImageView!
    
    var appDelegate: AppDelegate!
    
    var statusReply:String!
    
    var isPatch:Bool = false
    var patchItemId: Int?
    var patchItemTitle:String?
    var patchItemValue:Int?
    var patchItemDescription:String?
    var patchItemPhoto1:UIImage?
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var addPhoto1: UIButton?
    @IBOutlet weak var addPhoto2: UIButton!
    @IBOutlet weak var addPhoto3: UIButton!
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextField: UITextField!
    @IBOutlet weak var itemAmount: UITextField!
    
    @IBOutlet weak var categoryCell: UITableViewCell!

    let uploadAlert = UIAlertView()
    
    @IBAction func postButtonAction(sender: UIButton) {
        
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
            }
            
        }
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
        
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        // End of adding logo to Navigation Bar
        
//        self.hideKeyboardWhenTappedAround() 
        
        // for testing
        itemNameTextField.text = "Pudding"
        itemDescriptionTextField.text = "This is a pudding I made. It's very good."
        itemAmount.text = "1"
        itemPriceTextField.text = "100"
        
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
                "image_1" : "data:image/jpeg;base64,\(base64String1)"],
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
                        })
                    }
                }
                
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
                "image_1" : "data:image/jpeg;base64,\(base64String1)"],
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
                            self.postButton.enabled = true
                        })
                        
                        self.isPatch = false
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
