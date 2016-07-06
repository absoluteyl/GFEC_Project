//
//  LoginViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/29.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let theDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var isReLoggingIn:Bool = false
    
    @IBOutlet weak var topLabel: UILabel!

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButtonAction(sender: UIButton) {
        
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            topLabel.text = "Please enter username & password!"
        } else {
            self.performSegueWithIdentifier("goNext", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goNext" {
        let Destination : LoggingInViewController = segue.destinationViewController as! LoggingInViewController
        Destination.useremail = userNameTextField.text
        Destination.password = passwordTextField.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isReLoggingIn == true {
            self.navigationController!.navigationBar.hidden = true
            isReLoggingIn = false
        }
        userNameTextField.text = "kyujyokei@gmail.com"
        passwordTextField.text = "effort"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
}
