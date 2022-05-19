//
//  Task.swift
//  To-Do Manager
//
//  Created by Nikita  on 5/16/22.
//

import Foundation

enum TaskPriority{
    case normal
    case important
}

enum TaskStatus{
    case planned
    case completed
}

protocol TaskProtocol{
    var status: TaskStatus {get set}
    var priority: TaskPriority {get set}
    var title: String {get set}
}

struct Task: TaskProtocol{
    var status: TaskStatus
    var priority: TaskPriority
    var title: String
}
