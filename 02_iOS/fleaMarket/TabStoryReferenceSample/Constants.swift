//
//  Constants.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/4.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: Get merchandise list or filter specific items
    struct Merchandises {
        static let APIBaseURL = "http://ririkoko.herokuapp.com/api/merchandises"
        //static let APIBaseURL = "http://flea-market-absoluteyl.c9users.io/api/merchandises"
    }
    
    struct Users {
        static let APIBaseURL = "http://ririkoko.herokuapp.com/api/users"
    }
    
    struct Locations {
        static let APIBaseURL = "http://ririkoko.herokuapp.com/api/locations"
    }
    
    // MARK: Merchandises Parameter Keys
    struct ParameterKeys {
        static let MerchandiseID = "id"
        static let MerchandiseTitle = "title"
        static let MerchandiseDescription = "description"
        static let MerchandisePrice = "price"
//        static let MerchandiseAmount = "amount"
        static let UserID = "user_id" // this is a int number generated as users create their id
        static let Username = "username" // this is a string users set as user name
        static let Password = "password"
        static let API_Key = "api_key"
        static let user = "user"
    }
    
    // MARK: Merchandises Parameter Values
    struct ParameterValues {
        static let MerchandiseID = ""
        static let MerchandiseTitle = ""
        static let MerchandiseDescription = ""
        static let MerchandisePrice = ""
        static let MerchandiseAmount = ""
        static let UserID = ""
        static let API_Key = "e813852b6d35e706f776c74434b001f9" //heroku
        //static let API_Key = "4484c065f013c7ff144f5c618fa8f341" //c9
        
     }
    
    // MARK: FleaMarket Response Keys
    struct MerchandisesResponseKeys {
        static let Merchandise = "merchandise"
        static let Merchandises = "merchandises"
        static let MerchandiseId = "id"
        static let MerchandiseTitle = "title"
        static let MerchandiseDescription = "description"
        static let MerchandisePrice = "price"
        static let MerchandiseAmount = "amount"
        static let UserID = "user_id"
        static let CreatedTime = "created_at"
        static let image_1_s = "image1_url_s"
        static let image_1_o = "image1_url_o"
    }
    
    struct UsersResponseKeys {
        static let UserId = "id"
        static let UserEmail = "email"
        static let UserMobile = "mobile"
        static let UserName = "username"
        static let Users = "users"
        static let User = "user"
        static let Avatar_O = "avatar_url_o"
        static let Avatar_M = "avatar_url_m"
        static let Avatar_S = "avatar_url_s"
    }
    
    struct  LocationRespondKeys {
        static let Location = "location"
        static let UserId = "user_id"
        static let PostCode = "postcode"
        static let City = "city"
        static let Address = "address"
        static let Recipient = "recipient"
        static let Phone = "phone"
        static let Latitude = "lat"
        static let Longtitude = "long"
    }
    
    
    // MARK: FleaMarket Response Values
    struct MerchandisesResponseValues {
    }
    
    // MARK: Get merchandise list or filter specific items
    struct Merchandise {
        static let APIBaseURL = "https://flea-market-absoluteyl.c9users.io/api/merchandises/"
    }
}