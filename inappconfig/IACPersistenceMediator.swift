//
//  IACDataMediator.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/25/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation


/*
Persist changes across views so selected elements can be reloaded on view reload
Allow undo/redo on changes made before saving to NSUserDefaults
Allow persistence of cached changes in NSUserDefaults
*/


public class IACPersistenceMediator:IACPersistanceDelegate {
    
    class func makePersistenceMediatorWithStandardDefaults() -> IACPersistenceMediator{
        return IACPersistenceMediator()
    }
    
    class func makePersistenceMediatorWithSuiteName(suiteName:String) -> IACPersistenceMediator {
        return IACPersistenceMediator(suiteName: suiteName)
    }
    
    class func makePersistenceMediatorWithAlternativeStorage(storage:IACKeyValueCoding) -> IACPersistenceMediator {
        return IACPersistenceMediator(storage: storage)
    }
    
    private init() {
        self.storage = NSUserDefaults.standardUserDefaults()
    }
    private init(suiteName:String) {
        self.storage = NSUserDefaults(suiteName: suiteName)!
    }
    private init(storage:IACKeyValueCoding) {
        self.storage = storage
    }
    
    private var storage:IACKeyValueCoding
  
    
    public func persistChangesToStorage(changes:[String:AnyObject?]) {
        for change in changes {
            storage.setValue(change.1, forKey: change.0)
        }
    }
    
    //Load the specified defaults from the cache
    //Some defaults may not exist, be careful when unwrapping defaults
    public func loadDefaultsFromStorageForKeys(keys:[String]) -> [String:AnyObject?] {
        var retVal = [String:AnyObject?]()
        for key in keys {
            retVal[key] = storage.valueForKey(key)
        }
        return retVal
    }
    
    
}