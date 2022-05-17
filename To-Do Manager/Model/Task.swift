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
    var title: String {get set}
    var priority: TaskPriority {get set}
    var status: TaskStatus {get set}
}

struct Task: TaskProtocol{
    var title: String
    var priority: TaskPriority
    var status: TaskStatus
}
