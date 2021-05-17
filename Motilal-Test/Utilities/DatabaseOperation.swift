//
//  DatabaseOperation.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 16/05/21.
//

import Foundation
import CoreData

class DatabaseOperation {
    
    private func isRecordExistsfor(id: Int) -> Bool{
        let result = getTodoTaskRecord(by: id)
        guard result != nil else {return false}
        return true
    }
    
    func addRecordData(taskId : Int, title: String, taskDescription: String, todoDate: Date, isReminderCheck: Bool) {
        let result = TodoTask(context: PersistentStorage.shared.context)
        result.title = title
        result.todoDescription = taskDescription
        result.todoDate = todoDate
        result.isReminder = isReminderCheck
        result.taskId = Int32(taskId)
        PersistentStorage.shared.saveContext()
    }
    
    func updateRecordData(taskId : Int, title: String, taskDescription: String, todoDate: Date, isReminderCheck: Bool) {
        if isRecordExistsfor(id: taskId){
            let result = getTodoTaskRecord(by: taskId)
            result?.title = title
            result?.todoDescription = taskDescription
            result?.todoDate = todoDate
            result?.isReminder = isReminderCheck
            PersistentStorage.shared.saveContext()
        }
    }
    
    func getTodoTaskRecord(by id: Int) -> TodoTask? {
        let idd = Int32(id)
        let fetchRequest = NSFetchRequest<TodoTask>(entityName: "TodoTask")
        let predicate = NSPredicate(format: "taskId==%i", idd)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result
        }catch let error{
            debugPrint(error)
        }
        return nil
    }
    
    func delete(id: Int){
        let result = getTodoTaskRecord(by: id)
        guard result != nil else {return}
        PersistentStorage.shared.context.delete(result!)
        PersistentStorage.shared.saveContext()
    }
    
}
