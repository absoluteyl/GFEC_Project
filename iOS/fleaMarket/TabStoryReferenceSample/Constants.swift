//
//  Constants.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/4.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: Flickr
    struct Webpage {
        static let APIBaseURL = "https://flea-market-absoluteyl.c9users.io/api/"
    }
    
    // MARK: Item Parameter Keys
    struct ParameterKeys {
        static let Merchandises = "merchandises"
//        static let APIKey = "api_key"
//        static let GalleryID = "id"
//        static let Extras = "extras"
//        static let Format = "format"
//        static let NoJSONCallback = "nojsoncallback"
    }
    
    // MARK: Flickr Parameter Values
    struct ParameterValues {
        static let Merchandises = "merchandises"
//        static let ResponseFormat = "json"
//        static let DisableJSONCallback = "1" /* 1 means "yes" */
//        static let GalleryPhotosMethod = "flickr.galleries.getPhotos"
//        static let GalleryID = "5704-72157622566655097"
//        static let MediumURL = "url_m"
    }
    
    // MARK: Flickr Response Keys
    struct itemResponseKeys {
        static let Id = "id"
        static let Title = "title"
        static let Description = "description"
        static let Price = "price"
        static let Amount = "amount"
        static let CreatedAt = "created_at"
        static let UpdatedAt = "updated_at"
        static let UserId = "user_id"
    }
    
    // MARK: Flickr Response Values
    struct FlickrResponseValues {
        static let OKStatus = "ok"
    }
}