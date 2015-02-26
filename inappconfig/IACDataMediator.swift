//
//  IACDataMediator.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/25/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation

class IACDataMediator {
    
    class func saveSelectedItemsForKey(selectedItems: [String], key: String) {
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(selectedItems, forKey: key)
        userDefaults.synchronize()
    }
}