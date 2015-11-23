//
//  Checklist.swift
//  TechbbowA2CheckLists
//
//  Created by ZhangZehua on 11/18/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding{
    var name = ""
    var items = [ChecklistItem]()
    var iconName: String
    
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("Name") as! String
        items = aDecoder.decodeObjectForKey("Items") as! [ChecklistItem]
        iconName = aDecoder.decodeObjectForKey("IconName") as! String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
        aCoder.encodeObject(iconName, forKey: "IconName")
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items {
            if !item.checked {
                count++
            }
        }
        return count
    }
    
    func sortChecklistItems() {
        items.sortInPlace({
            item1, item2 in return
            item1.dueDate.compare(item2.dueDate) == NSComparisonResult.OrderedAscending
        })
    }
}
