//
//  SettingCell.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/3/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit

class SettingCell : UITableViewCell {
    
    @IBOutlet var settingNameLabel: UILabel!
    var defaults: NSUserDefaults?
    
    func configureWithSetting( setting: Setting, defaults: NSUserDefaults ) {
        settingNameLabel.text = setting[ "Title"] as? String
        self.defaults = defaults
    }
    
}