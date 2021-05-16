//
//  TaskViewModel.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 15/05/21.
//

import UIKit

class TaskViewModel {
    
    var taskList = [TodoTaskModel]()
    
    func getTaskData() {
        
        do {
            guard let result = try PersistentStorage.shared.context.fetch(TodoTask.fetchRequest()) as? [TodoTask] else {return}
            result.forEach({
                debugPrint($0.title)
                //taskList.append(value.)// getTaskValue())
            })
            debugPrint(taskList.description)
        } catch let error {
            debugPrint(error)
        }
        
    }

    
}
