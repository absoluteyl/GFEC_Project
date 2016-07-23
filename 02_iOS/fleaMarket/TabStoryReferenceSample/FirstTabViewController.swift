//
//  FirstTabViewController.swift
//  TabStoryReferenceSample
//
//  Created by Kero on 2016/5/29.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit
import KFSwiftImageLoader
//import Firebase

//define an array of merchandise title for later use
var titleArray = [String]()
var priceArray = [Int]()
var itemIdArray = [Int]()
var imageArray = [String]()

class FirstTabViewController: UIViewController, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var refreshControl:UIRefreshControl!
    
    var selectedNumber:Int!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var MyCollectionViewCell: UICollectionViewCell!
    
    @IBOutlet weak var categoryScroll: UIScrollView!
    
    var hasGotAPIYet: Bool = false
    
    override func viewWillAppear(animated: Bool) {
        titleArray = []
        priceArray = []
        itemIdArray = []
        imageArray = []
            getDataFromDB()
        
//        activityIndicator.startAnimating()
        
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let bgImage = UIImageView();
        bgImage.image = UIImage(named: "bg");
        bgImage.contentMode = .ScaleToFill
        
        self.collectionView?.backgroundView = bgImage
        self.collectionView?.backgroundView!.contentMode = UIViewContentMode.ScaleAspectFill
        
        
        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        // End of adding logo to Navigation Bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:",   forControlEvents: UIControlEvents.ValueChanged)
        collectionView!.addSubview(refreshControl)
        
        categoryScroll.backgroundColor = UIColorUtil.rgb(0xffffff);
        
    }
    
    func refresh(sender:AnyObject)
    {
        titleArray = []
        priceArray = []
        itemIdArray = []
        imageArray = []
        getDataFromDB()
        self.refreshControl.endRefreshing()
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
    


    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData() //螢幕轉直or橫時會更新cell的大小
    }
    
    //有幾個section
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //有幾個cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    
    //cell中顯示內容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        // This following section let the images have time to load before showing
        cell.imageView.loadImageFromURLString(imageArray[indexPath.row], placeholderImage: UIImage(named: "first")) {
            (finished, potentialError) in
            
            if finished {
                // Do something in the completion block.
            }
            else if let error = potentialError {
                print("error occurred with description: \(error.localizedDescription)")
            }
        }
        
    
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
       // cell.imageView.image = UIImage(named:images[indexPath.row]) //顯示圖片
        cell.cellLabel.text = "\(titleArray[indexPath.row])" //顯示物件名稱
        cell.cellPriceLabel.text = "$ \(priceArray[indexPath.row])"//顯示價格
        
        var itemId = itemIdArray[indexPath.row] //給予每個cell item id，為了讓itemDetailView可以正確顯示
        
        return cell
    }


    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Sends the item id for itemDetailView to load the specific item details
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let Destination : itemDetailViewController = segue.destinationViewController as! itemDetailViewController
        //let selectedNumber = sender as! Int
        Destination.recentItemId = itemIdArray[selectedNumber]
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
         //self.navigationController?.pushViewController(v1, animated: true)//連接到商品頁面
        selectedNumber = indexPath.row
        self.performSegueWithIdentifier("showItemDetail", sender: indexPath.row)
    }
    

    private func getDataFromDB() {
        

        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
        ]
        
        //print(methodParameters)
        
        let urlString = Constants.Merchandises.APIBaseURL + escapedParameters(methodParameters)
        
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
                    
                    
                   
                    let itemDictionary = parsedResult![Constants.MerchandisesResponseKeys.Merchandises] as? [[String:AnyObject]]
                   //print(itemDictionary)
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    for i in 0...itemDictionary!.count-1 {
                        let itemTitle = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseTitle] as? String
                        //print (itemTitle!)
                        let itemPrice = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandisePrice] as? Int
                        let itemId = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseId] as? Int
                        let itemImage = itemDictionary![i][Constants.MerchandisesResponseKeys.image_1_s] as? String
                        
                        
                        priceArray.append(itemPrice!)
                        titleArray.append(itemTitle!)
                        itemIdArray.append(itemId!)
                        imageArray.append(itemImage!)
                    
                    }
                    //print(priceArray)
                    //print(titleArray)
                    //print(itemIdArray)
                    
                    //print("3.\(titleArray.count)")
                    
                    performUIUpdatesOnMain(){
                        self.collectionView.reloadData()
                        self.activityIndicator.stopAnimating()
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
