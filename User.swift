//
//  User.swift
//  Tribe
//

import Foundation
import CoreData

class User: NSManagedObject
{
    @NSManaged var email: String?
    @NSManaged var firstname: String?
    @NSManaged var lastname: String?
    @NSManaged var password: String?
    
}
