//
//  IACPickerViewController.swift
//  inappconfig
//
//  Created by Scott A. Guyer on 2/4/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation
import UIKit


//
// This will be used for multivalue and radio group pickers

class IACPickerViewController : UITableViewController {
    
    var items: Array<String>?
    var key: String?
    var selectedItems = [String]()
    var allowMultipleSelections = false
    var delegate:IACPersistanceDelegate?

    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = items {
            return rows.count
        }
        else {
            return 0
        }
    }
    
    
    
    func determineAccessoryForItem( item: String ) -> UITableViewCellAccessoryType {
        if let index = find( selectedItems, item) {
            return .Checkmark
        }
        else {
            return .None
        }
    }
    
    
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier( "pickerCell") as! UITableViewCell
        
        if let i = items {
            let value = i[ indexPath.row]
            cell.textLabel?.text = value
            
            cell.accessoryType = determineAccessoryForItem(value)
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if let i = items {
            let item = i[indexPath.row]
            
            if let index = find(selectedItems,item) {
                selectedItems.removeAtIndex(index)
            } else {
                selectedItems.append(item)
            }
            
            cell?.accessoryType = determineAccessoryForItem(item)
        }
    }

    override func viewWillDisappear(animated: Bool) {
        var changes = [String:AnyObject]()
        changes[self.key!] = selectedItems
        delegate?.persistChangesToStorage(changes)
    }
    
}

