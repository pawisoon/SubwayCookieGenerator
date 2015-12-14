//
//  LogItem.swift
//  Subway Cookie
//
//  Created by Paul Szydlowski on 03/11/2015.
//  Copyright © 2015 Pawel Szydlowski. All rights reserved.
//

import Foundation
import CoreData

class LogItem: NSManagedObject {
    @NSManaged var code: Int
    @NSManaged var email: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, code: Int, email: String) -> LogItem {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("User_data", inManagedObjectContext: moc) as! LogItem
        newItem.code = code
        newItem.email = email
        
        return newItem
    }
}