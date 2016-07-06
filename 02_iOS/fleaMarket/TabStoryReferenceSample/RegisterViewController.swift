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
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        uploadimage = info[UIImagePickerControllerOriginalImage]! as! UIImage; dismissViewControllerAnimated(true, completion: nil)
        dispatch_async(dispatch_get_main_queue()) {
            self.addPhotoButton!.setTitle("", forState: .Normal)
            self.addPhotoButton!.setImage(self.uploadimage, forState: .Normal)
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
    

}
