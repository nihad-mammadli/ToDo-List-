//
//  Task+CoreDataProperties.swift
//  ToDo List
//
//  Created by Nebula on 14.07.24.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: Date?

}

extension Task : Identifiable {

}
