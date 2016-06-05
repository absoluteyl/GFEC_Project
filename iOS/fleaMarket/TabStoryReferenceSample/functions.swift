//
//  functions.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/4.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import Foundation
import UIKit

public func escapedParameters(parameters: [String:AnyObject]) -> String {
    
    if parameters.isEmpty {
        return ""
    } else {
        var keyValuePairs = [String]()
        
        for (key, value) in parameters {
            
            // make sure that it is a string value
            let stringValue = "\(value)"
            
            // escape it
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            // append it
            keyValuePairs.append(key + "=" + "\(escapedValue!)")
            
        }
        
        return "\(keyValuePairs)?"
        //return "?\(keyValuePairs.joinWithSeparator("&"))"
    }
}



public func getImageFromFlickr() {
    
//    let methodParameters = [
//        Constants.ParameterKeys.Merchandises: Constants.ParameterValues.Merchandises
//    ]
    
    //let urlString = Constants.Webpage.APIBaseURL + escapedParameters(methodParameters)
    let urlString = "https://flea-market-absoluteyl.c9users.io/api/merchandises"
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
                
                let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                theDelegate.itemArray = parsedResult as? NSArray
                

                performUIUpdatesOnMain(){
//                    self.itemArray = itemArray
                        //reload table view
                }
                print (itemArray!)
//                if let itemTitle = itemDictionary![Constants.itemResponseKeys.Title] as? String {
//                        performUIUpdatesOnMain(){
//                            cell.cellLabel.text = itemTitle
//                        }
                }

            
                
                }
            
        }
    
    task.resume()
    
    }



