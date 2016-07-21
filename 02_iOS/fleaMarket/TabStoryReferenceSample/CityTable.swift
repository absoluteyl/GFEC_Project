//
//  CityTable.swift
//  fleaMarket
//
//  Created by Kero on 2016/7/18.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

let menuTappedDone = "menuTappedDone"
var selectedNumber = 0

class CityTable: UITableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dictionaries.CityDictionary.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel!.text = Dictionaries.CityArray[indexPath.row]
        
        return cell
    }
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        theDelegate.cityTemp = indexPath.row
        //print(theDelegate.cityTemp)
        
        var storyboard = UIStoryboard(name: "FillInAddress", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("FillInAddressViewController") as! FillInAddressViewController

//        controller.chooseCityButton.setTitle("Hi" , forState: .Normal)
        selectedNumber = theDelegate.cityTemp
        
        navigationController?.popViewControllerAnimated(false)
            
        NSNotificationCenter.defaultCenter().postNotificationName(menuTappedDone, object: self ,userInfo: nil)

        self.dismissViewControllerAnimated(true) { () -> Void in
        
        }
    }
    
    
}


