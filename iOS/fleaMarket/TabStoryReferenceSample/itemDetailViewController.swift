//
//  itemDetailViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/1.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class itemDetailViewController: UIViewController {

    @IBAction func backButton(sender: UIButton) {
        self.performSegueWithIdentifier("goBack", sender: self )
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
