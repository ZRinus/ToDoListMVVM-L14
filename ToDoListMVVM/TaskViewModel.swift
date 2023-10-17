//
//  TaskViewModel.swift
//  ToDoListMVVM
//
//  Created by Rinat Zaripov on 12.09.2023.
//

import Foundation
import UIKit

struct State {
    enum EditingStyle {
        case addTask(String)
        case deleteTask(IndexPath)
        case toggleTask(IndexPath)
        case loadTasks([TaskItem])
        case none
    }
    
    var todolistArray: [TaskItem]
    var editingStyle: EditingStyle {
        didSet {
            switch editingStyle {
            case let .addTask(newTaskName):
                var newTask = TaskItem()
                newTask.taskName = newTaskName
                todolistArray.append(newTask)
                break
            case let .deleteTask(indexPath):
                todolistArray.remove(at: indexPath.row)
                break
            case let .toggleTask(indexPath):
                todolistArray[indexPath.row].isTaskComplete.toggle()
                break
            case let .loadTasks(array):
                todolistArray = array
                break
            case .none:
                break
            }
        }
    }
    
    init(array: [TaskItem]) {
        todolistArray = array
        editingStyle = .none
    }
    
    func text(at indexPath: IndexPath) -> String {
        return todolistArray[indexPath.row].taskName
    }
    
    func isComplete(at indexPath: IndexPath) -> Bool {
        return todolistArray[indexPath.row].isTaskComplete
    }
}

class TaskViewModel {
    var state = State(array: []) {
        didSet {
            callBack(state)
        }
    }
    
    let callBack: (State) -> ()
    
    init(callback: @escaping (State) -> ()) {
        self.callBack = callback
    }
    
    func addNewTask(taskName: String) {
        state.editingStyle = .addTask(taskName)
    }
    
    func deleteTask(at indexPath: IndexPath) {
        state.editingStyle = .deleteTask(indexPath)
        saveTasks()
    }
    
    func toggleTask(at indexPath: IndexPath) {
        state.editingStyle = .toggleTask(indexPath)
        saveTasks()
    }
    
    func accessoryType(at indexPath: IndexPath) -> UITableViewCell.AccessoryType {
        if state.isComplete(at: indexPath) {
            return .checkmark
        }

    
    func saveTasks() {
        let defaults = UserDefaults.standard
        
        do {
            let encodedata = try JSONEncoder().encode(state.todolistArray)
                
                defaults.set(encodedata, forKey: "taskItemArray")
        } catch {
            print("unable to encode \(error)")
        }
    }
    
    func loadTask() {
        let defaults = UserDefaults.standard
        
        do {
            if let data = defaults.data(forKey: "taskItemArray") {
                
                let array = try JSONDecoder().decode([TaskItem].self, from: data)
                
                state.editingStyle = .loadTasks(array)
            }
        } catch {
            print("Unable to Encode Array (\(error))")
        }
    }
}
