//
//  IACSliderCell.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/3/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit


class IACSliderCell : SettingCell {
    
    @IBOutlet var slider: UISlider!
    
    override func loadDefaults() {
        self.key = self.setting["Key"] as! String
        if let defaultVal: AnyObject = delegate?.loadDefaultsFromStorageForKey(self.key) {
            slider.value = (defaultVal as! NSNumber).floatValue
        }
        else {
            if let defaultVal = setting["DefaultValue"] as? NSNumber {
                slider.value = defaultVal.floatValue
            }
        }
    }
    
    override func persistSelfInfo() {
        NSLog("Persisting slider")
        var changes:[String:AnyObject?] = [self.key:NSNumber(float: slider.value)]
        delegate?.persistChangesToStorage(changes)
    }
    
}