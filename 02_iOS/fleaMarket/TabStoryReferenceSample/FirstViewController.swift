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
        
    }
    
    func goToLoginPage() {
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

