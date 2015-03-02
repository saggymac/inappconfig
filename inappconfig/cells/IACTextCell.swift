//
//  IACTextCell.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/3/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit


class IACTextCell : SettingCell {
    @IBOutlet var valueField: UITextField!
    
    override func loadDefaults() {
        self.key = self.setting["Key"] as! String
        if let defaultVal: AnyObject = delegate?.loadDefaultsFromStorageForKey(self.key) {
            valueField.text = defaultVal as! String
        }
        else {
            if let defaultVal = setting["DefaultValue"] as? String {
                valueField.text = defaultVal
            }
        }
    }
    
    override func persistSelfInfo() {
        var changes:[String:AnyObject?] = [self.key:valueField.text]
        delegate?.persistChangesToStorage(changes)
    }
    
    
}