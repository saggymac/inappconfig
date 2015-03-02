//
//  AppGroupPersistanceDelegate.swift
//  inappconfig
//
//  Created by Mecklenburg, William on 2/26/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation

public protocol IACPersistanceDelegate {
    func persistChangesToStorage(changes:[String:AnyObject?])
    func loadDefaultsFromStorageForKey(key:String) -> AnyObject?
}