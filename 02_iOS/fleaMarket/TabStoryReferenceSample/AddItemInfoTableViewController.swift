//
//  AddItemInfoTableViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/11.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit



class AddItemInfoTableViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let categoriesArray = ["Women's Clothing","Men's Clothing","Games & Toys","Sports & Outdoors","Accessories","Electronics & Computers","Cell Phones & Accessories","Home & Living","Mom & Baby","Food & Beverage","Cameras & Lens","Books & Audible","Handmade","Tickets","Pets"]
    
    var categoryNumber:Int!
    var hasSelectedCategory:Bool = false
    
    @IBOutlet var StaticTableView: UITableView!
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var imageSelected: UIImage!
    
    @IBOutlet weak var tempImageVIew: UIImageView!
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var addPhoto1: UIButton?
    @IBOutlet weak var addPhoto2: UIButton!
    @IBOutlet weak var addPhoto3: UIButton!
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextField: UITextField!
    @IBOutlet weak var itemAmount: UITextField!
    
    @IBOutlet weak var categoryCell: UITableViewCell!
    
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
        addPhoto1 = sender
        post()
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
                self.performSegueWithIdentifier("showCategory", sender: indexPath.row)
            } else if indexPath.row == 0 {
                self.performSegueWithIdentifier("showItemStatus", sender: indexPath.row)
            } else if indexPath.row == 2 {
                self.performSegueWithIdentifier("showDelivery", sender: indexPath.row)
            }
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if appDelegate.itemCategoryNumber != -1 {
            categorySelectedName.text = categoriesArray[appDelegate.itemCategoryNumber]
        }
        
        if categoryNumber != nil {
            categoryCell.detailTextLabel!.text = categoriesArray[categoryNumber]
        }
        
        
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for testing
        itemNameTextField.text = "Pudding"
        itemDescriptionTextField.text = "This is a pudding I made. It's very good."
        itemAmount.text = "1"
        itemPriceTextField.text = "100"
        

     
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
        
//        func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
//            print("You selected cell number: \(indexPath.row)!")
//            //self.performSegueWithIdentifier("yourIdentifier", sender: self)
//        }
        
        //print("64STRING:\(base64String1)")
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let params:[String: AnyObject] = [
            "merchandise":[
                "title" : itemNameTextField.text!,
                "description" : itemDescriptionTextField.text!,
                "price" : itemPriceTextField.text!,
                "amount" : itemAmount.text!,
                "user_id" : self.theDelegate.userID,
                "category_id" : appDelegate.itemCategoryNumber,
                "image_1" : "data:image/jpeg;base64,\(base64String1)"],
            
        ]
        
        print("CATEGORY:\(appDelegate.itemCategoryNumber)")
        
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
        self.performSegueWithIdentifier("backToTab1Segue", sender: postButton)
        
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
