//
//  IACMultiValueCell.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/3/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit

/*
The cell that, when a user taps it, will open up a multipicker
*/
class IACMultiValueCell : SettingCell {
    
    @IBOutlet var currentValue: UILabel!
    
    override func loadDefaults() {
        var currentSelected:String = ""
        self.key = self.setting["Key"] as! String
        if let defaultVal: AnyObject = delegate?.loadDefaultsFromStorageForKey(self.key) {
            let selected = defaultVal as! Array<String>
            for choice in selected {
                currentSelected += choice + " "
            }
        }
        else {
            if let defaultVal = setting["DefaultValue"] as? Array<String> {
                let selected = defaultVal
                for choice in selected {
                    currentSelected += choice
                }
            }
        }
        currentValue.text = currentSelected
    }
}