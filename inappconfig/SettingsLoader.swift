//
//  SettingsLoader.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/2/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation



public class SettingsLoader {
    
    public class func readPropertyListData( data: NSData ) -> Settings? {
    
        var err: NSError? = nil
        
        let plistObj: AnyObject? = NSPropertyListSerialization.propertyListWithData(data, options: 0, format: nil, error: &err)
        
        if let topLevel = plistObj as? Dictionary<String,AnyObject> {
            if let specs = topLevel[ "PreferenceSpecifiers"] as? Array<Dictionary<String,AnyObject>> {
                return specs as Settings
            }
        }
        
        return nil
    }
    
}