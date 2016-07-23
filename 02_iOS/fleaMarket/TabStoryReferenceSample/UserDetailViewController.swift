//
//  UserDetailViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/25.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import KFSwiftImageLoader

var titleArray_1 = [String]()
var priceArray_1 = [Int]()
var itemIdArray_1 = [Int]()
var imageArray_1 = [String]()

class UserDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var userId:Int!
    var userImageUrl:String!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        titleArray_1 = []
        priceArray_1 = []
        itemIdArray_1 = []
        imageArray_1 = []
        getUserFromDB()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //決定每個cell的大小
        if traitCollection.horizontalSizeClass == .Compact && traitCollection.verticalSizeClass == .Regular {
            //如果是直的
            
            return CGSize(width: view.bounds.width / 2.3, height: 210)
        }else{
            return CGSize(width: 200, height: 200)
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: nil)
        addButton.tintColor = UIColor.clearColor()
        navigationItem.rightBarButtonItem = addButton
        // End of adding logo to Navigation Bar

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray_1.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        // This following section let the images have time to load before showing
        cell.imageView.loadImageFromURLString(imageArray_1[indexPath.row], placeholderImage: UIImage(named: "first")) {
            (finished, potentialError) in
            
            if finished {
                // Do something in the completion block.
            }
            else if let error = potentialError {
                print("error occurred with description: \(error.localizedDescription)")
            }
        }
        
//        let imageURL = NSURL(string: imageArray_1[indexPath.row])
//        if let imageData = NSData(contentsOfURL: imageURL!) {
//            cell.imageView.image = UIImage(data: imageData)!
//        } else {
//            print("Image does not exist at \(imageURL)")
//        }
        
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        // cell.imageView.image = UIImage(named:images[indexPath.row]) //顯示圖片
        cell.cellLabel.text = "\(titleArray_1[indexPath.row])" //顯示物件名稱
        cell.cellPriceLabel.text = "$ \(priceArray_1[indexPath.row])"//顯示價格
        
        var itemId = itemIdArray_1[indexPath.row] //給予每個cell item id，為了讓itemDetailView可以正確顯示
        
        return cell
    }
    


    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let Destination : itemDetailViewController = segue.destinationViewController as! itemDetailViewController
        let selectedNumber = sender as! Int
        Destination.recentItemId = itemIdArray[selectedNumber]
    }
    
    
    //https://ririkoko.herokuapp.com/api/merchandises?api_key=e813852b6d35e706f776c74434b001f9&user=1

    
    //api/users/1?api_key=xxx
    
    
    private func getUserFromDB(){
    
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
            ]
        
        print(methodParameters)
        
        let urlString = Constants.Users.APIBaseURL + "/\(userId)" + escapedParameters(methodParameters)
        
        print("URL:\(urlString)")
        
        
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        var itemArray:NSArray?
        
        
        // if an error occur, print it
        func displayError(error: String) {
            print(error)
            print("URL at time of error: \(url)")
            
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            if error == nil {
                if let data = data {
                    let parsedResult: AnyObject!
                    do {
                        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) //change 16 bit JSON code to redable format
                    } catch {
                        displayError("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    
                    //print(parsedResult)
                    
                    let userDictionary = parsedResult![Constants.UsersResponseKeys.User] as? [String:AnyObject]
                    
                    let itemDictionary = parsedResult![Constants.MerchandisesResponseKeys.Merchandises] as? [[String:AnyObject]]
                    
                    for i in 0...itemDictionary!.count-1 {
                        let itemTitle = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseTitle] as? String
                        //print (itemTitle!)
                        let itemPrice = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandisePrice] as? Int
                        let itemId = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseId] as? Int
                        let itemImage = itemDictionary![i][Constants.MerchandisesResponseKeys.image_1_s] as? String
                        
                        
                        priceArray_1.append(itemPrice!)
                        titleArray_1.append(itemTitle!)
                        itemIdArray_1.append(itemId!)
                        imageArray_1.append(itemImage!)
                        
                    }
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    
                        let userName = userDictionary![Constants.UsersResponseKeys.UserName] as! String!
                        let userImage = userDictionary![Constants.UsersResponseKeys.Avatar_S] as! String!
                        let ImgUrl = NSURL(fileURLWithPath: userImage)
                
                    print(userImage)
                    performUIUpdatesOnMain(){
                        self.userNameLabel.text = userName
//                        self.userImageUrl = userImage
                        self.collectionView.reloadData()
                       
                        self.userImage.loadImageFromURLString(userImage)
                        //print(ImgUrl)
                        
                        
                    }
                }
            }
        }
        task.resume()
    
    }
    
    

    
    func escapedParameters(parameters: [String:AnyObject]) -> String {
        if parameters.isEmpty {
            return ""
        } else {
            var keyValurPairs = [String]()
            
            for (key, value) in parameters {
                
                // make sure it is a string value (convert the ones aren't)
                let stringValue = "\(value)"
                
                //escape it
                let escapeValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) //convert string to ASCII compliant version of a string, returns characters considered safe ASCIIs only
                
                //append it
                keyValurPairs.append(key + "=" + "\(escapeValue!)")
                
            }
            return "?\(keyValurPairs.joinWithSeparator("&"))"
        }
        
    }

}
