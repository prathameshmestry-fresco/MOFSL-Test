//
//  TodoTask+CoreDataProperties.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 16/05/21.
//
//

import Foundation
import CoreData


extension TodoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTask> {
        return NSFetchRequest<TodoTask>(entityName: "TodoTask")
    }

    @NSManaged public var isReminder: Bool
    @NSManaged public var title: String?
    @NSManaged public var todoDate: Date?
    @NSManaged public var todoDescription: String?

    func getTodoTaskModel() -> TodoTaskModel {
        var model = TodoTaskModel()
        model.title = title
        model.description = todoDescription
        model.taskDate = todoDate
        model.isReminder = isReminder
        return model
    }
}

extension TodoTask : Identifiable {

}
