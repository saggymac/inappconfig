//
//  IACViewController.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/2/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit



public class IACViewController : UIViewController, UITableViewDelegate {
    public var dataSource: SettingsDataSource!
    
    lazy var defaults: NSUserDefaults = {
       return NSUserDefaults.standardUserDefaults()
    }()

    @IBOutlet var tableView: UITableView!
    
    
    public override func awakeFromNib() {

    }
    
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.tableView.reloadData()
    }
    
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.tableView.dataSource = dataSource
        self.tableView.delegate = self
        
    }
    
    
    //
    // TODO: need to rework this so that defaults is not known to this view controller
    //
    func openPickerForIndexPath( indexPath: NSIndexPath, setting: Setting, multi: Bool ) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("pickerViewController") as IACPickerViewController
        
        vc.items = setting[ "Titles"] as? Array<String>
        vc.allowMultipleSelections = multi
        
        // TODO: also need to fallback to defaults if there is nothing in NSUserDefaults
        
        if let key = setting[ "Key"] as? String {
            vc.key = key
            if let currentValues = defaults.valueForKey( key) as? Array<String> {
                vc.selectedItems = currentValues
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    // TODO: this needs to be moved from here
    func openChildPaneForIndexPath( indexPath: NSIndexPath, setting: Setting ) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("settingsViewController") as IACViewController
        
        if let plistName = setting[ "File"] as? String {
            if let path = NSBundle.mainBundle().pathForResource( plistName, ofType: "plist") {
                let ds = SettingsDataSource( propertyListFile: path, defaults:NSUserDefaults.standardUserDefaults() )
                vc.dataSource = ds;
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath( indexPath, animated: false)
        
        if let setting = dataSource.setting( indexPath) {
            
            let type = setting[ "Type"] as String
            
            switch type {
                
            case "PSMultiValueSpecifier" :
                openPickerForIndexPath( indexPath, setting: setting, multi: false)

            case "PSRadioGroupSpecifier" :
                openPickerForIndexPath( indexPath, setting: setting, multi: true)
                
            case "PSChildPaneSpecifier" :
                openChildPaneForIndexPath( indexPath, setting: setting)
                
            default:
                NSLog( "we do not support tapping on rows of type \(setting)")
                
            }
        }
            
 
        
    }
    
}