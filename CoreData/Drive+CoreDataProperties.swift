//
//  Drive+CoreDataProperties.swift
//  itaxo
//
//  Created by Genuine on 23.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import CoreData


extension Drive {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drive> {
        return NSFetchRequest<Drive>(entityName: "Drive")
    }

    @NSManaged public var car_id: Int64
    @NSManaged public var date: String//Date
    @NSManaged public var distance: String//Double
    @NSManaged public var driver_id: Int64
    @NSManaged public var from: String//Int64
    @NSManaged public var id: Int64
    @NSManaged public var paiment_id: String//Int64
    @NSManaged public var polyline: String
    @NSManaged public var status: Bool
    @NSManaged public var to: String//Int64
    @NSManaged public var user_id: Int64
    @NSManaged public var newRelationship: NSSet?
    @NSManaged public var newRelationship1: GeoPoint
    @NSManaged public var newRelationship2: NSSet?

}


extension Drive {

    @objc(addNewRelationshipObject:)
    @NSManaged public func addToNewRelationship(_ value: Payment)

    @objc(removeNewRelationshipObject:)
    @NSManaged public func removeFromNewRelationship(_ value: Payment)

    @objc(addNewRelationship:)
    @NSManaged public func addToNewRelationship(_ values: NSSet)

    @objc(removeNewRelationship:)
    @NSManaged public func removeFromNewRelationship(_ values: NSSet)

}


extension Drive {

    @objc(addNewRelationship2Object:)
    @NSManaged public func addToNewRelationship2(_ value: Payment)

    @objc(removeNewRelationship2Object:)
    @NSManaged public func removeFromNewRelationship2(_ value: Payment)

    @objc(addNewRelationship2:)
    @NSManaged public func addToNewRelationship2(_ values: NSSet)

    @objc(removeNewRelationship2:)
    @NSManaged public func removeFromNewRelationship2(_ values: NSSet)

}
