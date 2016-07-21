//
//  S01_AddressTableViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/7.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

var addressArray = [String]()

class S01_AddressTableViewController: UITableViewController {
    
    

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        print(addressArray.count)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        // End of adding logo to Navigation Bar
        
        //let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "buttonMethod")
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonMethod")
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    func addButtonMethod () {
        self.performSegueWithIdentifier("showFillAddress", sender: "addButton")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if addressArray.count == 0 {
            return 1
        } else {
            return addressArray.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if addressArray.count != 0 {
            
            cell.textLabel!.text = addressArray[indexPath.row]
            
        } else {
            cell.textLabel!.text = "Tap to add address"
        }

        return cell
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == addressArray.count {
            self.performSegueWithIdentifier("showFillAddress", sender: indexPath.row)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
