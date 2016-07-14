//
//  Chat.swift
//  fleaMarket
//
//  Created by Kero on 2016/7/14.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import Photos

class Chat: UIViewController, UITableViewDataSource, UITableViewDelegate,
UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

        // Instance variables
        @IBOutlet weak var textField: UITextField!
        @IBOutlet weak var sendButton: UIButton!
        var ref: FIRDatabaseReference!
        var messages: [FIRDataSnapshot]! = []
        var msglength: NSNumber = 10
        private var _refHandle: FIRDatabaseHandle!
        
        var storageRef: FIRStorageReference!
        var remoteConfig: FIRRemoteConfig!
        

        @IBOutlet weak var clientTable: UITableView!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.clientTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
            
            configureDatabase()
            configureStorage()
            configureRemoteConfig()
            fetchConfig()
            logViewLoaded()
        }
        
        deinit {
            self.ref.child("messages").removeObserverWithHandle(_refHandle)
        }
        
        func configureDatabase() {
            ref = FIRDatabase.database().reference()
            //Listen for new messages in the Firebase database
            _refHandle = self.ref.child("messages").observeEventType(.ChildAdded, withBlock : { (snapshot) -> Void in
                self.messages.append(snapshot)
                self.clientTable.insertRowsAtIndexPaths([NSIndexPath(forRow: self.messages.count-1, inSection:0)], withRowAnimation: .Automatic)
            })
        }
        
        func configureStorage() {
            storageRef = FIRStorage.storage().referenceForURL("gs://friendlychat-ac2ee.appspot.com")
        }
        
        func configureRemoteConfig() {
            remoteConfig = FIRRemoteConfig.remoteConfig()
            // Create Remote Config Setting to enable developer mode.
            // Fetching configs from the server is normally limited to 5 requests per hour.
            // Enabling developer mode allows many more requests to be made per hour, so developers
            // can test different config values during development.
            let remoteConfigSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
            remoteConfig.configSettings = remoteConfigSettings!
            
        }
        
        func fetchConfig() {
            var expirationDuration: Double = 3600
            // If in developer mode cacheExpiration is set to 0 so each fetch will retrieve values from
            // the server.
            if (self.remoteConfig.configSettings.isDeveloperModeEnabled) {
                expirationDuration = 0
            }
            
            // cacheExpirationSeconds is set to cacheExpiration here, indicating that any previously
            // fetched and cached config would be considered expired because it would have been fetched
            // more than cacheExpiration seconds ago. Thus the next fetch would go to the server unless
            // throttling is in progress. The default expiration duration is 43200 (12 hours).
            remoteConfig.fetchWithExpirationDuration(expirationDuration) { (status, error) in
                if (status == .Success) {
                    print("Config fetched!")
                    self.remoteConfig.activateFetched()
                    let friendlyMsgLength = self.remoteConfig["friendly_msg_length"]
                    if (friendlyMsgLength.source != .Static) {
                        self.msglength = friendlyMsgLength.numberValue!
                        print("Friendly msg length config: \(self.msglength)")
                    }
                } else {
                    print("Config not fetched")
                    print("Error \(error)")
                }
            }
        }
        
        @IBAction func didSendMessage(sender: UIButton) {
            textFieldShouldReturn(textField)
        }
    
        
        func logViewLoaded() {
        }
    
        func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else { return true }
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= self.msglength.integerValue // Bool
        }
        
        // UITableViewDataSource protocol methods
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            // Dequeue cell
            let cell: UITableViewCell! = self.clientTable .dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath)
            // Unpack message from Firebase DataSnapshot
            let messageSnapshot: FIRDataSnapshot! = self.messages[indexPath.row]
            let message = messageSnapshot.value as! Dictionary<String, String>
            let name = message[Constants.MessageFields.name] as String!
            if let imageUrl = message[Constants.MessageFields.imageUrl] {
                if imageUrl.hasPrefix("gs://") {
                    FIRStorage.storage().referenceForURL(imageUrl).dataWithMaxSize(INT64_MAX){ (data, error) in
                        if let error = error {
                            print("Error downloading: \(error)")
                            return
                        }
                        cell.imageView?.image = UIImage.init(data: data!)
                    }
                } else if let url = NSURL(string:imageUrl), data = NSData(contentsOfURL: url) {
                    cell.imageView?.image = UIImage.init(data: data)
                }
                cell!.textLabel?.text = "sent by: \(name)"
            } else {
                let text = message[Constants.MessageFields.text] as String!
                cell!.textLabel?.text = name + ": " + text
                cell!.imageView?.image = UIImage(named: "ic_account_circle")
                if let photoUrl = message[Constants.MessageFields.photoUrl], url = NSURL(string:photoUrl), data = NSData(contentsOfURL: url) {
                    cell!.imageView?.image = UIImage(data: data)
                }
            }
            return cell!
        }
        
        // UITextViewDelegate protocol methods
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            let data = [Constants.MessageFields.text: textField.text! as String]
            sendMessage(data)
            return true
        }
        
        func sendMessage(data: [String: String]) {
            var mdata = data
            mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
            if let photoUrl = AppState.sharedInstance.photoUrl {
                mdata[Constants.MessageFields.photoUrl] = photoUrl.absoluteString
            }
            self.ref.child("messages").childByAutoId().setValue(mdata)
        }
        
        // MARK: - Image Picker
        
        @IBAction func didTapAddPhoto(sender: AnyObject) {
            let picker = UIImagePickerController()
            picker.delegate = self
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
                picker.sourceType = UIImagePickerControllerSourceType.Camera
            } else {
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            }
            
            presentViewController(picker, animated: true, completion:nil)
        }
        
        func imagePickerController(picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            picker.dismissViewControllerAnimated(true, completion:nil)
            
            // if it's a photo from the library, not an image from the camera
            if #available(iOS 9.0, *), let referenceUrl = info[UIImagePickerControllerReferenceURL] {
                let assets = PHAsset.fetchAssetsWithALAssetURLs([referenceUrl as! NSURL], options: nil)
                let asset = assets.firstObject
                asset?.requestContentEditingInputWithOptions(nil, completionHandler: { (contentEditingInput, info) in
                    let imageFile = contentEditingInput?.fullSizeImageURL
                    let filePath = "\(FIRAuth.auth()?.currentUser?.uid)/\(Int(NSDate.timeIntervalSinceReferenceDate() * 1000))/\(referenceUrl.lastPathComponent!)"
                })
            } else {
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                let imageData = UIImageJPEGRepresentation(image, 0.8)
                let imagePath = FIRAuth.auth()!.currentUser!.uid +
                    "/\(Int(NSDate.timeIntervalSinceReferenceDate() * 1000)).jpg"
            }
        }
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            picker.dismissViewControllerAnimated(true, completion:nil)
            
            // if it's a photo from the library, not an image from the camera
            if #available(iOS 8.0, *), let referenceUrl = info[UIImagePickerControllerReferenceURL] {
                //public class func fetchAssetsWithALAssetURLs(assetURLs: [NSURL], options: PHFetchOptions?) -> PHFetchResult
                func fetchAssetsWithALAssetURLs(assetURLs: [NSURL], options: PHFetchOptions?) -> PHFetchResult
                let assets = PHAsset.fetchAssetsWithALAssetURLs([referenceUrl as! NSURL], options: nil)
                let asset = assets.firstObject
                asset?.requestContentEditingInputWithOptions(nil, completionHandler: { (contentEditingInput, info) in
                    let imageFile = contentEditingInput?.fullSizeImageURL
                    let filePath = "\(FIRAuth.auth()?.currentUser?.uid)/\(Int(NSDate.timeIntervalSinceReferenceDate() * 1000))/\(referenceUrl.lastPathComponent!)"
                    self.storageRef.child(filePath)
                        .putFile(imageFile!, metadata: nil) { (metadata, error) in
                            if let error = error {
                                print("Error uploading: \(error.description)")
                                return
                            }
                            self.sendMessage([Constants.MessageFields.imageUrl: self.storageRef.child((metadata?.path)!).description])
                    }
                })
            } else {
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                let imageData = UIImageJPEGRepresentation(image, 0.8)
                let imagePath = FIRAuth.auth()!.currentUser!.uid +
                    "/\(Int(NSDate.timeIntervalSinceReferenceDate() * 1000)).jpg"
                let metadata = FIRStorageMetadata()
                metadata.contentType = "image/jpeg"
                self.storageRef.child(imagePath)
                    .putData(imageData!, metadata: metadata) { (metadata, error) in
                        if let error = error {
                            print("Error uploading: \(error)")
                            return
                        }
                        self.sendMessage([Constants.MessageFields.imageUrl: self.storageRef.child((metadata?.path)!).description])
                }
            }
        }
        
        @IBAction func signOut(sender: UIButton) {
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
                AppState.sharedInstance.signedIn = false
                dismissViewControllerAnimated(true, completion: nil)
            } catch let signOutError as NSError {
                print("Error signing out: \(signOutError)")
            }
        }
        
        func showAlert(title:String, message:String) {
            dispatch_async(dispatch_get_main_queue()) {
                let alert = UIAlertController(title: title,
                                              message: message, preferredStyle: .Alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .Destructive, handler: nil)
                alert.addAction(dismissAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }


