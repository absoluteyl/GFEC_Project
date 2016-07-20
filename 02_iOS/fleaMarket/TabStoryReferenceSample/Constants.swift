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
        static let APIBaseURL_login = "http://ririkoko.herokuapp.com/api/login"
        static let APIBaseURL_logout = "http://ririkoko.herokuapp.com/api/logout"
    }
    
    struct Locations {
        static let APIBaseURL = "http://ririkoko.herokuapp.com/api/locations"
    }
    
    // MARK: Merchandises Parameter Keys
    struct ParameterKeys {
        static let Id = "id"
        static let MerchandiseID = "id"
        static let MerchandiseTitle = "title"
        static let MerchandiseDescription = "description"
        static let MerchandisePrice = "price"
//        static let MerchandiseAmount = "amount"
        static let UserID = "user_id" // this is a int number generated as users create their id
        static let Username = "username" // this is a string users set as user name
        static let Password = "password"
        static let API_Key = "api_key"
        static let User = "user"
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
        static let Status = "status"
        static let LocationId = "location_id"
        static let CategoryId = "category_id"
    }
    
    struct UsersResponseKeys {
        static let UserId = "id"
        static let UserEmail = "email"
        static let UserMobile = "mobile"
        static let UserName = "username"
        static let Users = "users"
        static let User = "user"
        static let Avatar = "avatar"
        static let Avatar_O = "avatar_url_o"
        static let Avatar_M = "avatar_url_m"
        static let Avatar_S = "avatar_url_s"
        static let Status = "status"
    }
    
    struct  LocationRespondKeys {
        static let Id = "id"
        static let Location = "location"
        static let Locations = "locations"
        static let UserId = "user_id"
        static let PostCode = "postcode"
        static let City = "city"
        static let CityId = "city_id"
        static let Name = "name"
        static let ParentId = "parent_id"
        static let Address = "address"
        static let Recipient = "recipient"
        static let Phone = "phone"
        static let Latitude = "lat"
        static let Longtitude = "long"
        static let Status = "status"
        static let Alias = "alias"
    }
    
    struct CategoryArrays {
        static let CategoryTitleArray = ["Ｗomen’s Clothing","Men’s Clothing","Games & Toys","Sports & Outdoors","Accessories","Cosmetics & Care","Electronics & Computers","Cellphones & Accessories","Home & Living","Mom & Baby","Food & Beverage","Cameras & Lens","Books & Audible","Handmade","Tickets","Pets","Miscellaneous"]
        static let CategoryIdArray = ["1","11","77","84","19","26","34","43","49","57","64","69","92","99","104","110","115"]
    }
    
    struct CityArrays {
        static let CityNameArray = ["台北市","新北市","基隆市","宜蘭縣","桃園縣","新竹市","新竹縣","苗栗縣","台中市","彰化縣","南投縣","嘉義市","嘉義縣","雲林縣","台南市","高雄市","澎湖縣","屏東縣","台東縣","花蓮縣","金門縣","連江縣","南海諸島"]
    }
    
    struct ItemArrays {
        static let statusArray = ["Brand New & Unused","90% New","Still in Good Shape","Functionable & Slight Defects","Damaged"]
        static let deliveryArray = ["Mail","Meet Up","Takkyubin"]
    }
    
    //Below are for Firebase
    struct NotificationKeys {
        static let SignedIn = "onSignInCompleted"
    }
    
    struct Segues {
        static let SignInToFp = "SignInToFP"
        static let FpToSignIn = "FPToSignIn"
    }
    
    struct MessageFields {
        static let name = "name"
        static let text = "text"
        static let photoUrl = "photoUrl"
        static let imageUrl = "imageUrl"
    }
    
    
    // MARK: FleaMarket Response Values

    // MARK: Get merchandise list or filter specific items
    struct Merchandise {
        static let APIBaseURL = "https://flea-market-absoluteyl.c9users.io/api/merchandises/"
    }
}