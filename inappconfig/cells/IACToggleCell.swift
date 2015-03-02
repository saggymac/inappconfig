//
//  IACToggleCell.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/3/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit

class IACToggleCell : SettingCell {
    @IBOutlet var toggle: UISwitch!
    
    override func loadDefaults() {
        self.key = self.setting["Key"] as! String
        if let defaultVal: AnyObject = delegate?.loadDefaultsFromStorageForKey(self.key) {
            toggle.on = defaultVal as! Bool
        }
        else {
            if let defaultVal = setting["DefaultValue"] as? Bool {
                toggle.on = defaultVal
            }
        }
    }
    
    override func persistSelfInfo() {
        var changes:[String:AnyObject?] = [self.key:toggle.on]
        delegate?.persistChangesToStorage(changes)
    }
}