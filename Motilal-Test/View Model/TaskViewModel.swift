//
//  TaskViewModel.swift
//  Motilal-Test
//
//  Created by Prathamesh Mestry on 15/05/21.
//

import UIKit
import CoreData

class TaskViewModel {
    
    var taskList = [TodoTaskModel]()
    weak var vc: ViewController?
    
    func getTaskData() {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(TodoTask.fetchRequest()) as? [TodoTask] else {return}
            taskList.removeAll()
            result.forEach { (TodoTask) in
                taskList.append(TodoTask.getTodoTaskModel())
            }
            taskList = taskList.sorted(by: { $0.taskDate?.compare($1.taskDate!) == .orderedAscending })
            vc?.tableView.reloadData()
        } catch let error {
            debugPrint(error)
        }
    }
    
}
