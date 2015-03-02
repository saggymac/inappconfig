//
//  SettingCell.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/3/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit

/*
Base class for cells representing a plist setting.
Each cell subclass will be responsible for maintaining its own changes
Cells will then call persistInfo() to persist changes to the IACPersistanceMediator
*/
class SettingCell : UITableViewCell {
    
    @IBOutlet var settingNameLabel: UILabel!
    var key: String = ""
    var delegate: IACPersistanceDelegate?
    var setting: Setting = [String:AnyObject]()
    var changes = [String:AnyObject?]()
    
    func configureWithSetting( setting: Setting, delegate: IACPersistanceDelegate ) {
        self.setting = setting
        self.delegate = delegate
        
        settingNameLabel.text = setting[ "Title"] as? String
        
        loadDefaults()
    }
    
    //Overrides should not call this method.
    func loadDefaults() {
    }
    
    //Overrides should not call this method.
    @IBAction func persistSelfInfo() {

    }
}