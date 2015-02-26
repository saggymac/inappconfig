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
    
    override func configureWithSetting(setting: Setting, defaults: NSUserDefaults) {
        
        super.configureWithSetting( setting, defaults:defaults)
        
        
        // TODO: Check "Key" for value
        // Else, check "DefaultValue" and use that
        
        if let currentValue = setting[ ""] as? String {
            valueField.text = currentValue
        }
        
    }
    
    
}