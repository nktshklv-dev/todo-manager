//
//  TripViewController.swift
//  To-Do Manager
//
//  Created by Nikita  on 5/17/22.
//

import UIKit

class TripViewController: UITableViewController {

    //хранилище задач, методы load and save
    var tasksStorage: TaskStorageProtocol = TaskStorage()
    // коллекция задач
    var tasks: [TaskPriority: [TaskProtocol]] = [:]
    // порядок отображения секций по типам
    
    // индекс в массиве соответствует индексу секции в таблице
    var sectionsTypesPosition: [TaskPriority] = [.important, .normal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks() 
    }
    //добавление задач в массив задач tasks
    private func loadTasks(){
        sectionsTypesPosition.forEach{
            type in tasks[type] = []
        }
        tasksStorage.loadTasks().forEach{
            task in tasks[task.priority]?.append(task)
           
        }
        for (taskPriority, tasksGroup) in tasks{
            tasks[taskPriority] = tasksGroup.sorted{
                task1, task2 in task1.status.rawValue > task2.status.rawValue
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return  tasks.count
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     let taskTypeInSection = sectionsTypesPosition[section]
        guard let currentTasks = tasks[taskTypeInSection] else{
            return 0
        }
        return currentTasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getConfiguratedCell(for: indexPath)
        return cell
    }
    
    private func getConfiguratedCell(for indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellConstraints", for: indexPath)
        
        let type = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[type]?[indexPath.row] else{
            return cell
        }
        
        let textLabel = cell.viewWithTag(2) as? UILabel
        let iconLabel = cell.viewWithTag(1) as? UILabel
        
        iconLabel?.text = getIconForTask(with: currentTask.status)
        textLabel?.text = currentTask.title
        
        if currentTask.status == .planned{
            iconLabel?.textColor = .black
            textLabel?.textColor = .black
        }
        else if currentTask.status == .completed{
            iconLabel?.textColor = .lightGray
            textLabel?.textColor = .lightGray
        }
        return cell
        
    }
    
    private func getIconForTask(with status: TaskStatus) -> String{
        var resultSymbol: String = ""
        if status == .planned{
            resultSymbol = "\u{25CB}"
        }
        else if status == .completed{
            resultSymbol = "\u{25C9}"
        }
        else{
            resultSymbol = ""
        }
        return resultSymbol
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let tasksType = sectionsTypesPosition[section]
        if tasksType == .important{
            title = "Important"
        }
        else if tasksType == .normal{
            title = "Ordinary"
        }
        return title
        
    }
}
