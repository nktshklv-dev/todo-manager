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
    func loadTasks() -> [TaskProtocol] {
        let tasks = [Task(status: .completed, priority: .important, title: "Call mum"), Task(status: .planned, priority: .important, title: "Fuck Uliana"), Task(status: .planned, priority: .normal, title: "buy bread"), Task(status: .completed, priority: .normal, title: "Drink tea"), Task(status: .planned, priority: .important, title: "Пригласить на вечеринку Дольфа, Джеки, Леонардо, Уилла и Брюса")]
        return tasks
    }

     func saveTasks(tasks: [TaskProtocol]) {
        print("Shit")
    }
}
