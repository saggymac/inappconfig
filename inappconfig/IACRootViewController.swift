//
//  IACRootViewController.swift
//  inappconfig
//
//  Created by Mecklenburg, William on 2/27/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation


public class IACRootViewController : UIViewController {
    var vc:IACViewController?
    
    public override func viewDidLoad() {
        spawnDataViewRoot()
    }
    
    public func spawnDataViewRoot() {
        
        let sb = UIStoryboard(name: "IAC", bundle: nil)
        vc = sb.instantiateViewControllerWithIdentifier("settingsViewController") as? IACViewController
        
        if (vc != nil) {
            if let path = NSBundle.mainBundle().pathForResource("Top", ofType: "plist") {
                //TODO: Make this not use the standardUserDefaults
                let ds = SettingsDataSource( propertyListFile: path, defaults: NSUserDefaults.standardUserDefaults())
                vc!.dataSource = ds
                vc!.delegate = IACPersistenceMediator.makePersistenceMediatorWithStandardDefaults()
            }
        }
        self.navigationController?.pushViewController(vc!, animated: false)
    }
}