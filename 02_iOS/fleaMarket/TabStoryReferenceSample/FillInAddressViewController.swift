//
//  FillInAddressViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/18.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class FillInAddressViewController: UIViewController {
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func submitAddressButtonAction(sender: UIButton) {
//        let storyboard = UIStoryboard(name: "S01_Address", bundle: nil)
//        let controller = storyboard.instantiateViewControllerWithIdentifier("S01_AddressTable") as! S01_AddressTableViewController
//        
//        if addressTextField.text != "" {
//            controller.addressArray.append(addressTextField!.text!)
//            navigationController?.popViewControllerAnimated(true)
//        }

        addressArray.append(addressTextField.text!)
        NSUserDefaults.standardUserDefaults().setObject(addressArray, forKey: "tasks")
        navigationController?.popViewControllerAnimated(true)
        
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
