//
//  TaskItem.swift
//  ToDoListMVVM
//
//  Created by Rinat Zaripov on 12.09.2023.
//

import Foundation

struct TaskItem: Codable {
    var TaskName: String = ""
    var isTaskComplete: Bool = false
    
    init() {
        
    }
}
