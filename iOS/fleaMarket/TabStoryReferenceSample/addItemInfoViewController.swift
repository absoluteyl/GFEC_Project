//
//  addItemInfoViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/10.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

let inputArray = ["Please put 1","PUT 2","PUT3"]

class addItemInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!

    
    var allCellsText = [String]()
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 5
        } else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // first section
        if indexPath.section == 0 {
            let textInputCell = tableView.dequeueReusableCellWithIdentifier("TextInputCell", forIndexPath: indexPath ) as! TextInputTableViewCell
            
            textInputCell.InputTextField.placeholder = inputArray[indexPath.row]

            
            
            return textInputCell
            
            // second section
        } else if indexPath.section == 1 {
            
            let selectCell = tableView.dequeueReusableCellWithIdentifier("SelectFromListCell", forIndexPath: indexPath ) as! SelectFromListTableViewCell
            //config the cell
            //selectCell.XXX =
            
            return selectCell
            
        } else {
            
            let showDataCell = tableView.dequeueReusableCellWithIdentifier("ShowDataCell", forIndexPath: indexPath ) as! ShowDataTableViewCell
            //config the cell
            //showDataCell =
            
            return showDataCell
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
