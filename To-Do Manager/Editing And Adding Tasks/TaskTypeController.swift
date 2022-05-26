//
//  TaskTypeController.swift
//  To-Do Manager
//
//  Created by Nikita  on 5/25/22.
//

import UIKit

class TaskTypeController: UITableViewController {
    

    typealias TypeCellDescription = (type: TaskPriority, title: String, description: String)
    
    // 2. коллекция доступных типов задач с их описанием
     var taskTypesInformation: [TypeCellDescription] = [
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
        return taskTypesInformation.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCellTableViewCell
        let typeDescription = taskTypesInformation[indexPath.row]
        
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
