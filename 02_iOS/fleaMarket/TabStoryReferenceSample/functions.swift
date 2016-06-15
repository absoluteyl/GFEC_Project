//
//  functions.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/4.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import Foundation
import UIKit



//public func escapedParameters(parameters: [String:AnyObject]) -> String {
//    
//    if parameters.isEmpty {
//        return ""
//    } else {
//        var keyValuePairs = [String]()
//        
//        for (key, value) in parameters {
//            
//            // make sure that it is a string value
//            let stringValue = "\(value)"
//            
//            // escape it
//            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
//            
//            // append it
//            keyValuePairs.append(key + "=" + "\(escapedValue!)")
//            
//        }
//        
//        return "\(keyValuePairs)?"
//        //return "?\(keyValuePairs.joinWithSeparator("&"))"
//    }
//}



//public func getImageFromFlickr() {
//    
////    let methodParameters = [
//<<<<<<< HEAD
////        Constants.ParameterKeys.Merchandises: Constants.ParameterValues.Merchandises
////    ]
//    
//    //let urlString = Constants.Webpage.APIBaseURL + escapedParameters(methodParameters)
//    let urlString = "https://flea-market-absoluteyl.c9users.io/api/merchandises"
//=======
////        Constants.Merchandises: Constants.ParameterValues.Merchandises
////    ]
////    
//    let urlString = Constants.Merchandises.APIBaseURL
//    //let urlString = "https://flea-market-absoluteyl.c9users.io/api/merchandises"
//>>>>>>> 571ec72cbc0f35f952e3b57cb346c56fb6f58a38
//    let url = NSURL(string: urlString)!
//    let request = NSURLRequest(URL: url)
//    var itemArray:NSArray?
//    
//    
//    // if an error occur, print it
//    func displayError(error: String) {
//        print(error)
//        print("URL at time of error: \(url)")
//
//    }
//    
//    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
//        
//        if error == nil {
//            if let data = data {
//                let parsedResult: AnyObject!
//                do {
//                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) //change 16 bit JSON code to redable format
//                } catch {
//                    displayError("Could not parse the data as JSON: '\(data)'")
//                    return
//                }
//                
//<<<<<<< HEAD
//                let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                theDelegate.itemArray = parsedResult as? NSArray
//                
//
//                performUIUpdatesOnMain(){
////                    self.itemArray = itemArray
//                        //reload table view
//                }
//                print (itemArray!)
////                if let itemTitle = itemDictionary![Constants.itemResponseKeys.Title] as? String {
////                        performUIUpdatesOnMain(){
////                            cell.cellLabel.text = itemTitle
////                        }
//                }
//
//            
//
//                //print(parsedResult)
//                
//                //convert parseResult into a Dictionary, so it becomes several dictionaries in an array
//                let itemDictionary = parsedResult as? [[String:AnyObject]]
//                //print(itemDictionary!)
//
//                
//                //grab every "title" in dictionaries by look into the array with for loop
//                for i in 0...itemDictionary!.count-1 {
//                    let itemTitle = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseTitle] as? String
//                    
//                    titleArray.append(itemTitle!)
//                    
//                }
//                print(titleArray)
//
//            }
//        }
//    
//    task.resume()
//    
//    }



