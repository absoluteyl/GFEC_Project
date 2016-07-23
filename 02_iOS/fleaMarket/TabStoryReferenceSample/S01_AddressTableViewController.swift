//
//  S01_AddressTableViewController.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/7.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import UIKit


class S01_AddressTableViewController: UITableViewController {
    
    var addressArray = [AddressForm]()

    override func viewWillAppear(animated: Bool) {
        addressArray = []
        getLocationFromDB()
        print(addressArray.count)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        // Beggining of adding logo to Navigation Bar
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 30, 45))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "logo.png")
        self.navigationItem.titleView = titleView
        navigationController!.navigationBar.barTintColor = UIColorUtil.rgb(0xffffff);
        // End of adding logo to Navigation Bar
        
        //let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "buttonMethod")
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonMethod")
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    func addButtonMethod () {
        self.performSegueWithIdentifier("showFillAddress", sender: "addButton")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if addressArray.count == 0 {
            return 1
        } else {
            return addressArray.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if addressArray.count != 0 {
            
            cell.textLabel!.text = self.addressArray[indexPath.row].postCode + Constants.CityArrays.CityNameArray[self.addressArray[indexPath.row].city_id-1] + self.addressArray[indexPath.row].name + self.addressArray[indexPath.row].address
            
        } else {
            cell.textLabel!.text = "Tap to add address"
        }

        return cell
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == addressArray.count {
            self.performSegueWithIdentifier("showFillAddress", sender: indexPath.row)
        }
    }

    private func getLocationFromDB() {
        
        var userDefault = NSUserDefaults.standardUserDefaults()
        
        //http://ririkoko.herokuapp.com/api/locations?user=1&api_key=e813852b6d35e706f776c74434b001f9
        
        let methodParameters: [String: String!] = [
            Constants.ParameterKeys.API_Key: Constants.ParameterValues.API_Key,
            Constants.ParameterKeys.User: String(userDefault.integerForKey("userID"))
        ]
        
        //print(methodParameters)
        
        let urlString = Constants.Locations.APIBaseURL + escapedParameters(methodParameters)
        
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
                    
                    let locationDictionary = parsedResult![Constants.LocationRespondKeys.Locations] as! [[String:AnyObject]]
                    print(locationDictionary)
                    
                    if locationDictionary != [] {
                    
                        //grab every "title" in dictionaries by look into the array with for loop
                        for i in 0...locationDictionary.count-1 {
                            
                            let tempLocation = AddressForm()
                            
                            tempLocation.id = locationDictionary[i][Constants.LocationRespondKeys.Id] as! Int
                            let cityArray = locationDictionary[i][Constants.LocationRespondKeys.City] as! [String:AnyObject]
                            tempLocation.city_id = cityArray[Constants.LocationRespondKeys.ParentId] as! Int
                            tempLocation.name = locationDictionary[i][Constants.LocationRespondKeys.Alias] as! String
                            tempLocation.address = locationDictionary[i][Constants.LocationRespondKeys.Address] as! String
                            tempLocation.postCode = cityArray[Constants.LocationRespondKeys.PostCode] as! String
                            self.addressArray.append(tempLocation)
                            
                        }
                      
                        performUIUpdatesOnMain(){
                                self.tableView.reloadData()
                            
                        }
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
