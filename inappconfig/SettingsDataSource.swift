//
//  SettingsDataSource.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/2/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit




public typealias Setting = Dictionary<String,AnyObject>
public typealias Settings = Array<Setting>


//
// An instance of Settings Data Source will encompass a "level" of a Settings plist config
//
public class SettingsDataSource : NSObject, UITableViewDataSource {

    var rawSettings: Settings? = nil
    var settings: Array<Settings>? = nil
    var defaults: NSUserDefaults
    
    
    func processSettingsIntoGroups( settings: Settings ) -> Array<Settings>? {
        var result = Array<Settings>()
        var accum = Settings()
        
        for item in settings {
            
            let type = item[ "Type"] as? String
            
            if type == "PSGroupSpecifier" {
                if accum.count > 0 {
                    result.append( accum)
                }

                accum = Settings()
            }
            else {
                accum.append( item)
            }
        }
        
        if accum.count > 0 {
            result.append( accum)
        }
        
        return result
    }
    
    
    public init( propertyListFile: String, defaults: NSUserDefaults ) {
        
        self.defaults = defaults
        
        super.init()
        
        if let d = NSData( contentsOfFile: propertyListFile) {
            rawSettings = SettingsLoader.readPropertyListData( d)
        }
        
        if let raw = rawSettings {
            settings = processSettingsIntoGroups( raw)
        }

    }
    
    
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result: Int = 0
        
        if settings != nil {
            let sectionData = settings![ section]
            
            result = countElements( sectionData)
        }
        
        return result
    }
    
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if settings != nil {
            return countElements( settings!)
        }
        else {
            return 0
        }
    }
    
    
    public func setting( indexPath: NSIndexPath ) -> Setting? {
        var result: Setting? = nil
        
        if settings != nil {
            let section = settings![ indexPath.section]
            result = section[ indexPath.row]
        }
        
        return result
    }
    
    
    func reuseIdentifierForSettingType( type: String) -> String {
        return "\(type)-Cell"
    }
    
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var resultCell = UITableViewCell()
        
        if let pref = setting( indexPath) {
            if let type = pref[ "Type"] as? String {
                if let cell = tableView.dequeueReusableCellWithIdentifier( reuseIdentifierForSettingType( type)) as? SettingCell {
                    cell.configureWithSetting( pref, defaults:defaults)
                    resultCell = cell
                }
            }
        }
        

        return resultCell
    }

    
}