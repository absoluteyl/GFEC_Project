//
//  FirstViewController.swift
//  TabStoryReferenceSample
//
//  Created by Telieh Lin on 2016/5/28.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
        
        if theDelegate.hasLoggedIn == false {
        let timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "goNext", userInfo: nil, repeats: false)
            
        }
        
    }
    
    func goToLoginPage() {
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

