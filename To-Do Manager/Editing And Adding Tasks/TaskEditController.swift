//
//  TaskEditController.swift
//  To-Do Manager
//
//  Created by Nikita  on 5/24/22.
//

import UIKit

class TaskEditController: UITableViewController {
    
    
    var taskText:String = ""
    var taskType:TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    

    @IBOutlet var TaskTitleField: UITextField!
    
    @IBOutlet var taskTypeLabel: UILabel!

    @IBOutlet var taskStatusSwitch: UISwitch!
    
    
    
    
    private var taskTypes: [TaskPriority: String] = [ .important: "Important", .normal: "Normal"]
    
    
    
  

    override func viewDidLoad() {
        super.viewDidLoad()

        TaskTitleField?.text = taskText
        taskTypeLabel.text = taskTypes[taskType]
        if taskStatus == .completed{
            taskStatusSwitch.isOn = true
        }
      
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem){
        let title = TaskTitleField?.text ?? ""
        let type = taskType
        let status: TaskStatus = taskStatusSwitch.isOn ? .completed : .planned
        doAfterEdit?(title, type, status)
        navigationController?.popViewController(animated: true)
        
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTypeScreen"{
            let destination = segue.destination as! TaskTypeController
            destination.selectedType = taskType
            destination.doAfterTypeSelected = {
                type in
                self.taskType = type
                self.taskTypeLabel.text = self.taskTypes[type]
               
            }
        }
    }

}
