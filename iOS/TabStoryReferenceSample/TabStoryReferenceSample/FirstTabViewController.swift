//
//  FirstTabViewController.swift
//  TabStoryReferenceSample
//
//  Created by Kero on 2016/5/29.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class FirstTabViewController: UIViewController, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var MyCollectionViewCell: UICollectionViewCell!
    let images = ["animal1","animal2","animal3","animal4","animal5","animal6","animal7","animal8","animal9","animal10","animal11","animal12"]
    
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
        return images.count
    }
    
    //cell中顯示內容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named:images[indexPath.row])
        cell.cellLabel.text = "\(images[indexPath.row])"
        
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
