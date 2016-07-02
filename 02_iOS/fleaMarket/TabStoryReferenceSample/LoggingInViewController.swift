//
//  LoggingInViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/29.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class LoggingInViewController: UIViewController {
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    var useremail: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        login()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func login() {
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key
        ]
        
        //print(methodParameters)
        
        let urlString = Constants.Users.APIBaseURL_login + escapedParameters(methodParameters)
        
        //print(urlString)
        
        let url = NSURL(string: urlString)!
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let params:[String: AnyObject] = [
                "user_login":[
                    "email": "\(useremail)",
                    "password": "\(password)"
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
                    
                    
                    let userDictionary = parsedResult! as? [String:AnyObject]
                    
                    let statusReply = parsedResult![Constants.UsersResponseKeys.Status] as? String
                    
                    
                    //print("DIC:\(userDictionary)")
                    
                    /*
                     {"status":"OK","message":"You're successfully signed in.","id":1,"email":"chinbo@gmail.com","authentication_token":"RxxXWabraXoVTA5Cz5rQ"}
                     */
                    
                    let userDoc = userDictionary! as? [String:AnyObject]
                    print("USER DOC:\(userDoc)")
                    
                    let userID = userDoc![Constants.UsersResponseKeys.UserId] as! Int
                    let userName = userDoc![Constants.UsersResponseKeys.UserName] as! String
                    let userImage = userDoc![Constants.UsersResponseKeys.Avatar] as? String
                    
                    print("ID:\(userID)")
                    
                    
                    
                    if statusReply! == "OK" {
                        performUIUpdatesOnMain(){
                            
                            var userDefault = NSUserDefaults.standardUserDefaults()
                            
                            userDefault.setBool(true, forKey: "hasLoggedIn")
                            userDefault.setObject(self.useremail, forKey: "userEmail")
                            userDefault.setInteger(userID , forKey: "userID")
                            
                            self.resultLabel.text = "Welcome!\(userName)!"
                            
                            let imageURL = NSURL(string: userImage!)
                            if let imageData = NSData(contentsOfURL: imageURL!) {
                                self.userImage.image = UIImage(data: imageData)!
                            } else {
                                print("Image does not exist at \(imageURL)")
                            }
                            self.activityIndicator.stopAnimating()
                            
                            let seconds = 1.2
                            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                            
                            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                                
                                self.performSegueWithIdentifier("goMain", sender: self)
                                
                            })
                        }
                    } else {
                    
                        if let navigationController = self.navigationController
                        {
                            navigationController.popViewControllerAnimated(true)
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
