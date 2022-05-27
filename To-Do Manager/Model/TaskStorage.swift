//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Nikita  on 5/16/22.
//

import Foundation

protocol TaskStorageProtocol{
     func loadTasks() -> [TaskProtocol]
    func saveTasks(tasks: [TaskProtocol])
}

class TaskStorage: TaskStorageProtocol{
    private var storage = UserDefaults.standard
    var storageKey = "key"
    
    private enum TaskKey: String {
        case title
        case type
        case status
    }
    func loadTasks() -> [TaskProtocol] {
        var resultTasks: [TaskProtocol] = []
        let tasksFromStorage = storage.array(forKey: storageKey) as? [[String: String]] ?? []
        for task in tasksFromStorage{
            guard let title = task[TaskKey.title.rawValue],
                  let typeRaw = task[TaskKey.type.rawValue],
                    let statusRaw = task[TaskKey.status.rawValue]
            else{
                continue
            }
            
            let type: TaskPriority = typeRaw == "important" ? .important : .normal
            let status: TaskStatus = statusRaw == "planned" ? .planned : .completed
            resultTasks.append(Task(status: status, priority: type
                                    , title: title))
        }
        return resultTasks
    }

     func saveTasks(tasks: [TaskProtocol]) {
         var arrayForStorage: [[String: String]] = []
         tasks.forEach{
             task in var newElementForStorage: Dictionary<String, String> = [:]
             newElementForStorage[TaskKey.title.rawValue] = task.title
             newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned ? "planned" : "completed")
             newElementForStorage[TaskKey.type.rawValue] = (task.priority == .important ? "important" : "normal")
             arrayForStorage.append(newElementForStorage)
         }
         storage.set(arrayForStorage, forKey: storageKey)
         
    }
}
