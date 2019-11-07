//
//  TaskListTableViewController.swift
//  Task Manager
//
//  Created by Adenilson Noronha da Silva Junior on 06/11/19.
//  Copyright © 2019 Adenilson Noronha da Silva Junior. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TaskListTableViewController: UITableViewController {

    var taskList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = Auth.auth().currentUser else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        Database.database().reference().child("tasks").child("\(user.uid)").observe(DataEventType.value) { (snapshot) in
            self.taskList.removeAll()
            for child in snapshot.children.allObjects{
                guard let dictionaryTask = (child as? DataSnapshot)?.value as? Dictionary<String, Any> else {
                    print("Failed to parse Task")
                    continue
                }
                let task = Task.mapDictionaryToTask(dictionaryTask)
                self.taskList.append(task)
            }
            self.tableView.reloadData()
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.bind(task: taskList[indexPath.row])
        return cell
    }
}
