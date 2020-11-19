//
//  User+CoreDataProperties.swift
//  itaxo
//
//  Created by Genuine on 19.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var phone: Int16
    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var password: String?

}
