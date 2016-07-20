//
//  RegisteringViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/7/6.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class RegisteringViewController: UIViewController {
    
    var userName:String!
    var email:String!
    var mobile:String!
    var password:String!
    var statusReply:String!
    var uploadimage:UIImage?
    var base64String1:String!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
            activityIndicator.startAnimating()
            post()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func post () {
        
        let methodParameters: [String: String!] = [Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,]
        
        print(methodParameters)
        
        let url = NSURL(string: Constants.Users.APIBaseURL + escapedParameters(methodParameters))
        
        
        let request = NSMutableURLRequest(URL: url!)
        
        print(request)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //print(self.theDelegate.userID)
        

            var imageT : UIImage = (uploadimage)!
        
        var imageData1 = UIImageJPEGRepresentation(imageT, 1.0)
        
        base64String1 = imageData1!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        //        func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        //            print("You selected cell number: \(indexPath.row)!")
        //            //self.performSegueWithIdentifier("yourIdentifier", sender: self)
        //        }
        
        //print("64STRING:\(base64String1)")
        
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var userDefault = NSUserDefaults.standardUserDefaults()
        
        let params:[String: AnyObject] = [
            "user":[
                "username" : userName,
                "email" : email,
                "mobile" : mobile,
                "password" : password,
                ],
            //"avatar" : "data:image/jpeg;base64,\(base64String1)"
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
                        self.activityIndicator.stopAnimating()
                        self.textLabel.text = "Account created.Please check your mail box for confrimation email."
                    } else {
                        self.activityIndicator.stopAnimating()
                        self.textLabel.text = "Something went wrong!"
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
