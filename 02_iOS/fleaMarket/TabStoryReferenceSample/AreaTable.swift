//
//  AreaTable.swift
//  fleaMarket
//
//  Created by Kero on 2016/7/18.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import Foundation

class AreaTable: UITableViewController {
    
    var numberOfRows:Int?
    
    var theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if theDelegate.cityTemp == -1 {
            return 0
        } else {
            return PostalDictionay.PostalArray[theDelegate.cityTemp].count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel!.text = PostalDictionay.PostalArrayOfTuples[theDelegate.cityTemp][indexPath.row].1
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        theDelegate.cityNameTemp = PostalDictionay.PostalArrayOfTuples[theDelegate.cityTemp][indexPath.row].1
        theDelegate.postalTemp = PostalDictionay.PostalArrayOfTuples[theDelegate.cityTemp][indexPath.row].0
        
        //print(theDelegate.cityTemp)
        
    }

}
