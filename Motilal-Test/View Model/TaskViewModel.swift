//
//  TaskViewModel.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 15/05/21.
//

import UIKit

class TaskViewModel {
    
    var taskList = [TodoTaskModel]()
    var vc: ViewController?
    
    func getTaskData() {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(TodoTask.fetchRequest()) as? [TodoTask] else {return}
            
            result.forEach { (TodoTask) in
                taskList.append(TodoTask.getTodoTaskModel())
            }
            vc?.tableView.reloadData()
            debugPrint(taskList.description)
        } catch let error {
            debugPrint(error)
        }
        
    }

    
}
