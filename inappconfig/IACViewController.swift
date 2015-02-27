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
    var dataSource: SettingsDataSource!
    var delegate:IACPersistanceDelegate?

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
    
    //Open a Picker View for the given plist setting, can be multi-pick or single-pick
    func openPickerForIndexPath( indexPath: NSIndexPath, setting: Setting, multi: Bool ) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("pickerViewController") as! IACPickerViewController
        
        vc.items = setting[ "Titles"] as? Array<String>
        vc.allowMultipleSelections = multi
        vc.delegate = delegate

        
        if let key = setting[ "Key"] as? String {
            vc.key = key
            let vals = delegate!.loadDefaultsFromStorageForKeys([key])
            if let selected = vals[key] as? Array<String> {
                //load from storage
                vc.selectedItems = selected
            } else {
                //load from defaults
                let selected = setting["DefaultValue"] as! Array<String>
                vc.selectedItems = selected
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    // TODO: this needs to be moved from here
    func openChildPaneForIndexPath( indexPath: NSIndexPath, setting: Setting ) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("settingsViewController") as! IACViewController
        
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
            
            let type = setting[ "Type"] as! String
            
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
    
    public override func viewWillDisappear(animated: Bool) {
        //
    }
}