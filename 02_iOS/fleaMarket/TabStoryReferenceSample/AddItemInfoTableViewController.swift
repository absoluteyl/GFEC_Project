//
//  AddItemInfoTableViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/11.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit

class AddItemInfoTableViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var addPhoto1: UIButton!
    @IBOutlet weak var addPhoto2: UIButton!
    @IBOutlet weak var addPhoto3: UIButton!
    
    @IBAction func addPhoto1Action(sender: UIButton) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        addPhoto1.setImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
//    }


}
