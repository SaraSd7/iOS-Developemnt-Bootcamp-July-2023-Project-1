//
//  TaskModel.swift
//  ToDoList
//
//  Created by Sara Sd on 17/01/1445 AH.
//

import Foundation

struct Task: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var priority: TaskPriority
    var backLog: TaskBacklog
    var isCompleted = false
}

enum TaskPriority: String, CaseIterable, Equatable {
    case low
    case medium
    case high
}

enum TaskBacklog: String, CaseIterable, Equatable {
    case backlog
    case todo
    case inProgress
    case done
    
    var title: String{
        switch self {
        case .backlog:
            return "BackLog"
        case .todo:
            return "To do"
        case .inProgress:
            return "In Progress"
        case .done:
            return "Done"
        }
    }
}
