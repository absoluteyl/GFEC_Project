//
//  AppDelegate.swift
//  TabStoryReferenceSample
//
//  Created by Telieh Lin on 2016/5/28.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var itemArray: NSArray?
    
    var itemCategoryNumber = -1
    var itemStatusNumber = -1
    var itemDeliveryNumber = -1
    var itemLocationId = -1
    var itemLocationTemp:String = ""
    var cityTemp = -1
    var postalTemp = -1
    var cityNameTemp = ""
    
    /*
     self.userDefault.setInteger(userID , forKey: "userID")
      userDefault.setBool(true, forKey: "hasLoggedIn")
     userDefault.setObject(self.useremail, forKey: "userEmail"
     setObject( forKey:"userName")
     */

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        if  NSUserDefaults.standardUserDefaults().boolForKey("hasLoggedIn") == true {
            let mainStoryBoard = UIStoryboard(name:"Main", bundle: nil)
            let targetViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("main")
            self.window?.rootViewController = targetViewController
        }
        
        FIRApp.configure()
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
        
        return true
    }
    
    func signedIn(user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        
        AppState.sharedInstance.displayName = user?.displayName ?? user?.email
        AppState.sharedInstance.photoUrl = user?.photoURL
        AppState.sharedInstance.signedIn = true
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.NotificationKeys.SignedIn, object: nil, userInfo: nil)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}



// MARK: Create URL from Parameters




