//
//  AreaTable.swift
//  fleaMarket
//
//  Created by Kero on 2016/7/18.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import Foundation

let menuTappedDone1 = "menuTappedDone1"
var selectedAreaNumber = 0

class AreaTable: UITableViewController {
    
    var numberOfRows:Int?
    
    var selectedCityId: Int?
    
    var theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if theDelegate.cityTemp == -1 {
            return 0
        } else {
            return PostalDictionay.PostalArrayOfTuples[selectedNumber].count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel!.text = PostalDictionay.PostalArrayOfTuples[selectedNumber][indexPath.row].1
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        var theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        theDelegate.postalTemp = indexPath.row + 1
        //print(theDelegate.cityTemp)
        
        var storyboard = UIStoryboard(name: "FillInAddress", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("FillInAddressViewController") as! FillInAddressViewController
        
        //        controller.chooseCityButton.setTitle("Hi" , forState: .Normal)
        selectedAreaNumber = indexPath.row
        
        navigationController?.popViewControllerAnimated(false)
        
        NSNotificationCenter.defaultCenter().postNotificationName(menuTappedDone1, object: self ,userInfo: nil)
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

}
