//
//  GeoPoint+CoreDataProperties.swift
//  itaxo
//
//  Created by Genuine on 23.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import CoreData


extension GeoPoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeoPoint> {
        return NSFetchRequest<GeoPoint>(entityName: "GeoPoint")
    }

    @NSManaged public var address: String?
    @NSManaged public var id: Int64
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var newRelationship: Drive?

}
