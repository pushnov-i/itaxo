//
//  Drive+CoreDataProperties.swift
//  itaxo
//
//  Created by Genuine on 18.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//
//

import Foundation
import CoreData


extension Drive {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drive> {
        return NSFetchRequest<Drive>(entityName: "Drive")
    }

    @NSManaged public var status: NSObject?
    @NSManaged public var id: Int64
    @NSManaged public var user_id: Int64
    @NSManaged public var paiment_id: Int64
    @NSManaged public var from: Int64
    @NSManaged public var to: Int64
    @NSManaged public var date: Date?
    @NSManaged public var distance: Double
    @NSManaged public var polyline: String?
    @NSManaged public var driver_id: Int64
    @NSManaged public var car_id: Int64

}
