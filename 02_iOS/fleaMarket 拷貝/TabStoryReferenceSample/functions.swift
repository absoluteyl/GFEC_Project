//
//  functions.swift
//  fleaMarket
//
//  Created by Kero on 2016/6/4.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import Foundation
import UIKit


struct UIColorUtil {
    static func rgb(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public class AddressForm {
    var id:Int = 0
    var city_id:Int = 0
    var name:String = ""
    var address:String = ""
    var postCode:String = ""
}

public func findCategoryNameById(number:Int) -> String {
    switch number {
    case 1:
        return "Ｗomen’s Clothing"
    case 11:
        return "Men’s Clothing"
    case 77:
        return "Games & Toys"
    case 84:
        return "Sports & Outdoors"
    case 19:
        return "Accessories"
    case 26:
        return "Cosmetics & Care"
    case 34:
        return "Electronics & Computers"
    case 43:
        return "Cellphones & Accessories"
    case 49:
        return "Home & Living"
    case 57:
        return "Mom & Baby"
    case 64:
        return "Food & Beverage"
    case 69:
        return "Cameras & Lens"
    case 92:
        return "Books & Audible"
    case 99:
        return "Handmade"
    case 104:
        return "Tickets"
    case 110:
        return "Pets"
    case 115:
        return "Miscellaneous"
        
    default:
        return "Category"
    }
}

public func findKeyForValue(value: String, dictionary: [String: [String]]) ->String?
{
    for (key, array) in dictionary
    {
        if (array.contains(value))
        {
            return key
        }
    }
    return nil
}
