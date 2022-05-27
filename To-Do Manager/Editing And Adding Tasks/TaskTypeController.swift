//
//  TaskTypeController.swift
//  To-Do Manager
//
//  Created by Nikita  on 5/25/22.
//

import UIKit

class TaskTypeController: UITableViewController {
    

    typealias CellDescriptionType = (type: TaskPriority, title: String, description: String)
    
    var doAfterTypeSelected: ((TaskPriority) -> Void)?
    
    // 2. коллекция доступных типов задач с их описанием
     var taskTypesDescription: [CellDescriptionType] = [
        (type: .important, title: "Important", description: ".All the important tasks are displayed in the first section."), (type: .normal, title: "Normal", description: "Tasks with an ordinary priority are displayed above the important section")]
    
    var selectedType: TaskPriority = .normal
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellTypeNib = UINib(nibName: "TaskTypeCellTableViewCell", bundle: nil)
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TaskTypeCell")
        
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskTypesDescription.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCellTableViewCell
        let typeDescription = taskTypesDescription[indexPath.row]
        
        cell.typeName.text = typeDescription.title
        cell.typeDescription.text = typeDescription.description
        
        if selectedType == typeDescription.type{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }

      

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = taskTypesDescription[indexPath.row].type
        doAfterTypeSelected?(selectedType)
        navigationController?.popViewController(animated: true)
    }
    
}
