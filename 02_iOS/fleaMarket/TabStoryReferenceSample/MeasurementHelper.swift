//
//  MeasurementHelper.swift
//  fleaMarket
//
//  Created by Kero on 2016/7/14.
//  Copyright © 2016年 ColorKit. All rights reserved.
//

import Foundation
import Firebase

class MeasurementHelper: NSObject {
    
    static func sendLoginEvent() {
    }
    
    static func sendLogoutEvent() {
    }
    
    static func sendMessageEvent() {
    }
}

class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    var displayName: String?
    var photoUrl: NSURL?
}

