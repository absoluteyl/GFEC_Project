//
//  AddItemInfoTableViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/11.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class AddItemInfoTableViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var addPhoto1: UIButton!
    @IBOutlet weak var addPhoto2: UIButton!
    @IBOutlet weak var addPhoto3: UIButton!
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextField: UITextField!
    @IBOutlet weak var itemAmount: UITextField!
    
    @IBAction func postButtonAction(sender: UIButton) {
        post()
    }
    
    
    @IBAction func addPhoto1Action(sender: UIButton) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
        
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



    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        addPhoto1.setImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
    }

    private func post () {
        
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
        
        request.HTTPBody = "{\n\"title\": \"\(itemNameTextField.text!)\",\"description\": \"\(itemDescriptionTextField.text!)\", \"price\": \(itemPriceTextField.text!),\"amount\": \(itemAmount.text!),\"user_id\": \(self.theDelegate.userID!)}".dataUsingEncoding(NSUTF8StringEncoding);
        
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
