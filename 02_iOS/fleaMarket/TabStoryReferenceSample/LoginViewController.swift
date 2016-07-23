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
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
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
        Destination.userName = userNameTextField.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        registerButton.layer.cornerRadius = 6
        
        loginButton.layer.cornerRadius = 6
        
        if isReLoggingIn == true {
            self.navigationController!.navigationBar.hidden = true
            isReLoggingIn = false
        }
        userNameTextField.text = ""
        passwordTextField.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
}
