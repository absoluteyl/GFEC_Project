//
//  FourthTabViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/3.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class FourthTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var imageView: UIView!

    let contacts = ["Amy","Bob","Caroline","Dandy","Esla","Fergus","George","Harry","Issac"]
    let images = ["animal1","animal2","animal3","animal4","animal5","animal6","animal7","animal8","animal9","animal10","animal11","animal12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = contacts[indexPath.row]
        cell.imageView!.image = UIImage(named: images[indexPath.row])
        return cell
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
