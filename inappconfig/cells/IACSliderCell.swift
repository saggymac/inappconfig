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
    
    override func configureWithSetting(setting: Setting, defaults: NSUserDefaults) {
        super.configureWithSetting( setting, defaults:defaults)
        
    }
    
}