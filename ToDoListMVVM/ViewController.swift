//
//  ViewController.swift
//  ToDoListMVVM
//
//  Created by Rinat Zaripov on 12.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = TaskViewModel {[unowned self] (state) in
            switch state.editingStyle {
                
            case .addTask(_):
                textfield.text = ""
                break
            case .deleteTask(_):
                break
            case .toggleTask(_):
                break
            case .loadTasks(_):
                break
            case .none:
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadTask()
    }
    
    
    @IBAction func addNewTask(_ sender: Any) {
        
        viewModel?.addNewTask(taskName: textfield.text!)
    }
}

