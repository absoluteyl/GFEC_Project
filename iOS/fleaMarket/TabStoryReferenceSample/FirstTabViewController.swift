//
//  FirstTabViewController.swift
//  TabStoryReferenceSample
//
//  Created by Kero on 2016/5/29.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

//define an array of merchandise title for later use
var titleArray = [String]()
var priceArray = [Int]()



class FirstTabViewController: UIViewController, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var MyCollectionViewCell: UICollectionViewCell!
    let images = ["animal1","animal2","animal3","animal4","animal5","animal6","animal7","animal8","animal9","animal10","animal11","animal12","animal1","animal2","animal3","animal4","animal5","animal6","animal7","animal8","animal9","animal10","animal11","animal12"]
    let prices = ["1","2","3","4","5","6","7","8","9","100","110","120"]
    
    
    override func viewWillAppear(animated: Bool) {
        getImageFromFlickr()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1.\(titleArray.count)")
       // getImageFromFlickr()
        
        print("2.\(titleArray.count)")
        
        // Beggining of adding logo to Navigation Bar
        let logo = UIImage(named: "logo_temp_small.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        // End of adding logo to Navigation Bar
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //決定每個cell的大小
        if traitCollection.horizontalSizeClass == .Compact && traitCollection.verticalSizeClass == .Regular {
            //如果是直的
            return CGSize(width: 180, height: 180)
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
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.imageView.image = UIImage(named:images[indexPath.row]) //顯示圖片
        cell.cellLabel.text = "\(titleArray[indexPath.row])" //顯示物件名稱
        cell.cellPriceLabel.text = "$ \(priceArray[indexPath.row])"//顯示價格
        
        return cell
    }


    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
         //self.navigationController?.pushViewController(v1, animated: true)//連接到商品頁面
        self.performSegueWithIdentifier("showItemDetail", sender: indexPath.row)
    }
    

    public func getImageFromFlickr() {
        
        //    let methodParameters = [
        
        //        Constants.Merchandises: Constants.ParameterValues.Merchandises
        //    ]
        //
        let urlString = Constants.Merchandises.APIBaseURL
        //let urlString = "https://flea-market-absoluteyl.c9users.io/api/merchandises"
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
                    
                    let itemDictionary = parsedResult as? [[String:AnyObject]]
                    
                    //grab every "title" in dictionaries by look into the array with for loop
                    for i in 0...itemDictionary!.count-1 {
                        let itemTitle = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandiseTitle] as? String
                        //print (itemTitle!)
                        let itemPrice = itemDictionary![i][Constants.MerchandisesResponseKeys.MerchandisePrice] as? Int
                        
                        
                        
                        priceArray.append(itemPrice!)
                        titleArray.append(itemTitle!)
                        
                    }
                    print(priceArray)
                    print(titleArray)
                    print("3.\(titleArray.count)")
                    
                    performUIUpdatesOnMain(){
                        self.collectionView.reloadData()
                    }
                    
                    
                }
            }
        }
        
        task.resume()
        
    }
    

    
}
