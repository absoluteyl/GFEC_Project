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
        
        addPhoto1 = sender
        post()
        
    }
    @IBOutlet weak var categorySelectedName: UILabel!
    
    @IBAction func addPhoto1Action(sender: UIButton) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {        

          // setting the buuton image to selected image
//        let selectedImage = info[UIImagePickerControllerOriginalImage]! as! UIImage
//        addPhoto1.imageView?.backgroundColor = UIColor.clearColor()
//        addPhoto1.setImage(selectedImage, forState: UIControlState.Normal)
//        addPhoto1.imageView?.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
        
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
//        if categoryNumber != nil {
//            categorySelectedName.text = categoriesArray[categoryNumber]
//        }
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
        
        //let url = NSURL(string: Constants.Merchandises.APIBaseURL)!
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
        
        if imageData1 == nil {
            print("DATA1: NIL ")
        } else {
            print("DATA 1 OK")
        }
        
        func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
            print("You selected cell number: \(indexPath.row)!")
            //self.performSegueWithIdentifier("yourIdentifier", sender: self)
        }
        
        //print("64STRING:\(base64String1)")
        
//        request.HTTPBody = "{\"title\": \"\(itemNameTextField.text!)\",\"description\": \"\(itemDescriptionTextField.text!)\", \"price\": \(itemPriceTextField.text!),\"amount\": \(itemAmount.text!),\"user_id\": \(self.theDelegate.userID),\"image_1\": \(base64String1)}".dataUsingEncoding(NSUTF8StringEncoding);
        
        
        let params:[String: AnyObject] = [
            "merchandise":[
                "title" : itemNameTextField.text!,
                "description" : itemDescriptionTextField.text!,
                "price" : itemPriceTextField.text!,
                "amount" : itemAmount.text!,
                "user_id" : self.theDelegate.userID,
                "image_1" : "data:image/jpeg;base64,/\(base64String1)"]
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
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print(response)
                print(String(data: data, encoding: NSUTF8StringEncoding))
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
