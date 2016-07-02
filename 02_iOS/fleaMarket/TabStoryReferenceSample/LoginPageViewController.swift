//
//  LoginPageViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/14.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import Foundation

class LoginPageViewController: UIViewController {
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    var appDelegate: AppDelegate!
    
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(sender: UIButton) {
        
        if idTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            print("Username or Password Empty.")
        } else {
            login()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //for testing
        idTextField.text = "keroxie"
        passwordTextField.text = "effort"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    private func login() {
        
        
        
//        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let userPasswordString = "username@gmail.com:password"
//        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
//        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions()
//        let authString = "Basic \(base64EncodedCredential)"
//        config.HTTPAdditionalHeaders = ["Authorization" : authString]
//        let session = NSURLSession(configuration: config)
//        
//        var running = false
//        let url = NSURL(string: "https://example.com/api/v1/records.json")
//        let task = session.dataTaskWithURL(url!) {
//            (let data, let response, let error) in
//            if let httpResponse = response as? NSHTTPURLResponse {
//                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print(dataString)
//            }
//            running = false
//        }
//        
//        running = true
//        task.resume()
//        
//        while running {
//            print("waiting...")
//            sleep(1)
//        }
        
        //--------------------------------------------
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
            Constants.ParameterKeys.Username: idTextField.text,
            Constants.ParameterKeys.Password: passwordTextField.text
        ]
        
        print(methodParameters)
        
        let urlString = Constants.Users.APIBaseURL + escapedParameters(methodParameters)
        
        print(urlString)
        
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)

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
                    
//                    /* GUARD: Is the "id" key in parsedResult? */
//                    guard let userID = parsedResult![Constants.TMDBResponseKeys.UserID] as? Int else {
//                        displayError("Cannot find key '\(Constants.TMDBResponseKeys.UserID)' in \(parsedResult)")
//                        return
//                    }
//                    
//                    /* 6. Use the data! */
//                    self.appDelegate.userID = userID
//                    self.completeLogin()
                    
                    let userDictionary = parsedResult![Constants.UsersResponseKeys.Users] as? [[String:AnyObject]]
                    
                    //print("DIC:\(userDictionary)")
                    
                    let userDoc = userDictionary![0] as? [String:AnyObject]
                    print("USER DOC:\(userDoc)")
                    
                    let userID = userDoc![Constants.UsersResponseKeys.UserId] as! Int
                    
                    print("ID:\(userID)")
                    
                    self.userDefault.setInteger(userID, forKey: "userID")
                    
                    
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
