//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Nikita  on 5/16/22.
//

import Foundation

protocol TaskStorageProtocol{
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

class TasksStorage: TaskStorageProtocol{
    func loadTasks() -> [TaskProtocol] {
        let testTasks = [Task(title: "Buy bread", type: .normal, status: .planned),
                         Task(title: "Fuck some bitches", type: .important, status: .completed), Task(title: "Kill someine", type: .normal, status: .planned)]
        return testTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        print("BiptoFirst")
    }
    
    
}
