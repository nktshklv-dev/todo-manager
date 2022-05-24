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
    var tasks: [TaskPriority: [TaskProtocol]] = [:]{
        didSet{
            for (taskPriority, tasksGroup) in tasks{
                tasks[taskPriority] = tasksGroup.sorted{
                    task1, task2 in task1.status.rawValue > task2.status.rawValue
                }
            }
            
        }
    }
    // порядок отображения секций по типам
    
    // индекс в массиве соответствует индексу секции в таблице
    var sectionsTypesPosition: [TaskPriority] = [.important, .normal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTasks()
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    //добавление задач в массив задач tasks
    private func loadTasks(){
        sectionsTypesPosition.forEach{
            type in tasks[type] = []
        }
        tasksStorage.loadTasks().forEach{
            task in tasks[task.priority]?.append(task)
           
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
       let cell = getConfiguratedCell_customClass(for: indexPath)
        return cell
    }
 
    
    
    //второй способ
    private func getConfiguratedCell_customClass(for indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCell
        
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else{
            return cell
        }
        
        cell.title.text = currentTask.title
        cell.icon.text = getIconForTask(with: currentTask.status)
        
        if currentTask.status == .planned{
            cell.title.textColor = .black
            cell.icon.textColor = .black
        }
        else if currentTask.status == .completed{
            cell.title.textColor = .lightGray
            cell.icon.textColor = .lightGray
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else {
            return
        }
        
        guard tasks[taskType]![indexPath.row].status == .planned else{
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        tasks[taskType]![indexPath.row].status = .completed
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let taskType = sectionsTypesPosition[indexPath.section]
        
        guard let _ = tasks[taskType]?[indexPath.row] else{
            return nil
        }
        
        guard tasks[taskType]![indexPath.row].status == .completed else{
            return nil
        }
        
        let action = UIContextualAction(style: .normal, title: "Plan", handler: {
            _,_,_ in self.tasks[taskType]![indexPath.row].status = .planned
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        })
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let taskType = sectionsTypesPosition[indexPath.section]
        tasks[taskType]?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
