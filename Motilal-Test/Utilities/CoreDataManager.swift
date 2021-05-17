//
//  CoreDataManager.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 16/05/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    var taskList = [TodoTaskModel]()

    // Background Queue
    func performTaskInBackground() {
        DispatchQueue.global(qos: .background).async {
            self.saveDataToJson()
        }
    }
    
    func saveDataToJson() {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(TodoTask.fetchRequest()) as? [TodoTask] else {return}
            taskList.removeAll()
            result.forEach { (TodoTask) in
                taskList.append(TodoTask.getTodoTaskModel())
            }
            debugPrint(taskList.description)
        } catch let error {
            debugPrint(error)
        }
        
        JSONFileHelper.shared.writeToJSONFile(filename: "todo", model: taskList)
    }
    
}

