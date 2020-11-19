//
//  Payment+CoreDataProperties.swift
//  itaxo
//
//  Created by Genuine on 19.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var amount: Double
    @NSManaged public var created_at: Date?
    @NSManaged public var id: Int64
    @NSManaged public var status: Int16
    @NSManaged public var token: String?
    @NSManaged public var type: String?
    @NSManaged public var updated_at: Date?

}
