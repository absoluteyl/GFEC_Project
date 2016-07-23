//
//  FourthTabViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/3.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import Firebase

class FourthTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var contactImage: UIImageView!

    let contacts = ["Caroline"]
    let images = ["absolutely"]
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        //contactImage.layer.cornerRadius = 30
        //contactImage.clipsToBounds = true
        
        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        // End of adding logo to Navigation Bar
        
        
        
        let firebaseEmail = String(userDefault.objectForKey("userEmail")!)
//        let firebaseEmail = "keroxie@icloud.com"
        let firebasePassword = String(userDefault.objectForKey("userPassword")!)
        FIRAuth.auth()?.createUserWithEmail(firebaseEmail, password: firebasePassword) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.setDisplayName(user!)
        }
        
    }
    
    func setDisplayName(user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = String(userDefault.objectForKey("userName")!)
        changeRequest.commitChangesWithCompletion(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
   
    func signedIn(user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        
        AppState.sharedInstance.displayName = user?.displayName ?? user?.email
        AppState.sharedInstance.photoUrl = user?.photoURL
        AppState.sharedInstance.signedIn = true
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.NotificationKeys.SignedIn, object: nil, userInfo: nil)
        //performSegueWithIdentifier(Constants.Segues.SignInToFp, sender: nil)
    }
    
        override func viewDidAppear(animated: Bool) {
            if let user = FIRAuth.auth()?.currentUser{
                self.signedIn(user)
            }
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
        //cell.imageView!.bounds = CGRectMake(0.0, 0.0, 60.0, 60.0)
        //cell.imageView!.frame = CGRectMake(0.0, 0.0, 60.0, 60.0)
        cell.imageView!.layer.cornerRadius = 30 //cell.imageView!.layer.frame.height/2
        cell.imageView!.clipsToBounds = true //round contact images
        
        var itemSize:CGSize = CGSizeMake(60, 60)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.mainScreen().scale)
        var imageRect : CGRect = CGRectMake(0, 0, itemSize.width, itemSize.height)
        cell.imageView!.image?.drawInRect(imageRect)
        cell.imageView!.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("goChat", sender: self)
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
