//
//  CityTable.swift
//  fleaMarket
//
//  Created by Kero on 2016/7/18.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

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
        theDelegate.cityTemp = indexPath.row + 1
        print(theDelegate.cityTemp)
//        print(Array(Dictionaries.CityDictionary.keys))
        self.performSegueWithIdentifier("test", sender: indexPath.row)
    }

}
