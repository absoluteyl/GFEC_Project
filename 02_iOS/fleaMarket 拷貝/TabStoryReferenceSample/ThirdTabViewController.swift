//
//  ThirdTabViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/3.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class ThirdTabViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var Camera: UIButton!
    @IBOutlet weak var PhotoLibrary: UIButton!
    @IBOutlet weak var ImageDiaplay: UIImageView!
    
    var uploadimage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        // End of adding logo to Navigation Bar
        
        PhotoLibrary.backgroundColor = UIColor.clearColor()
        PhotoLibrary.layer.cornerRadius = 26
        PhotoLibrary.layer.borderWidth = 3
        PhotoLibrary.layer.borderColor = UIColor.whiteColor().CGColor
        
        Camera.backgroundColor = UIColor.clearColor()
        Camera.layer.cornerRadius = 26
        Camera.layer.borderWidth = 3
        Camera.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     button.backgroundColor = UIColor.clearColor()
     button.layer.cornerRadius = 5
     button.layer.borderWidth = 1
     button.layer.borderColor = UIColor.blackColor().CGColor
     */

    @IBAction func PhotoLibraryAction(sender: UIButton) {
    
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func CameraAction(sender: UIButton) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        uploadimage = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("goUploadSegue", sender: UIButton())
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let Destination : AddItemInfoTableViewController = segue.destinationViewController as! AddItemInfoTableViewController
        //Destination.recentItemId = itemIdArray[selectedNumber]
        Destination.imageSelected = uploadimage
    }
}
