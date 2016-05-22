//
//  Users+CoreDataProperties.swift
//  Tribe
//
//  Created by Georgia on 21/05/2016.
//  Copyright © 2016 Tristan Tambourine. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Users {

    @NSManaged var email: String?
    @NSManaged var firstname: String?
    @NSManaged var lastname: String?
    @NSManaged var password: String?

}
