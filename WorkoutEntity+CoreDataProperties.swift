//
//  WorkoutEntity+CoreDataProperties.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/12.
//
//

import Foundation
import CoreData


extension WorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutEntity> {
        return NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var satisfaction: String
    @NSManaged public var memo: String?

}

extension WorkoutEntity : Identifiable {

}
