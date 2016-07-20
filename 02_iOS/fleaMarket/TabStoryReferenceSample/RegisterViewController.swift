//
//  RegisterViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/7/6.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var uploadimage:UIImage?
    
    var statusReply:String?

    @IBAction func backButtonAction(sender: UIButton) {
//        self.navigationController?.popToRootViewControllerAnimated(true)
        performSegueWithIdentifier("goBack", sender: self)
        
    }
    

    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet weak var CreateButton: UIButton!
    
    @IBAction func addPhotoButtonAction(sender: UIButton) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func CreateButtonAction(sender: UIButton) {
        if userNameTextField.text != "" && emailTextField.text != "" && mobileTextField.text != "" && passwordTextField.text != "" && passwordTextField.text == passwordConfirmTextField.text {
            self.performSegueWithIdentifier("goNext", sender: CreateButton)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        uploadimage = info[UIImagePickerControllerOriginalImage]! as! UIImage; dismissViewControllerAnimated(true, completion: nil)
        dispatch_async(dispatch_get_main_queue()) {
            self.addPhotoButton!.setTitle("", forState: .Normal)
            self.addPhotoButton!.setImage(self.uploadimage, forState: .Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goNext" {
            let Destination : RegisteringViewController = segue.destinationViewController as! RegisteringViewController
            Destination.userName = userNameTextField.text
            Destination.email = emailTextField.text
            Destination.mobile = mobileTextField.text
            Destination.password = passwordTextField.text
            Destination.uploadimage = uploadimage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CreateButton.enabled = false
//        if userNameTextField.text != "" && emailTextField.text != "" && mobileTextField.text != "" && passwordTextField.text != "" && passwordTextField == passwordConfirmTextField {
//            CreateButton.enabled = true
//        }
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBarHidden = true
        
        let purple:UIColor = UIColorUtil.rgb(0x513969)
        
        backButton.backgroundColor = UIColor.clearColor()
        backButton.layer.cornerRadius = 6
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = purple.CGColor
        
        CreateButton.layer.cornerRadius = 6
        
        //for testing
        userNameTextField.text = "Bubui"
        passwordTextField.text = "buibui"
        passwordConfirmTextField.text = "buibui"
        emailTextField.text = "syugogetten0916@hotmail.com"
        mobileTextField.text = "0909126126"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
