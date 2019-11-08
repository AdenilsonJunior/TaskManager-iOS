//
//  AddTaskViewController.swift
//  Task Manager
//
//  Created by Adenilson Noronha da Silva Junior on 08/11/19.
//  Copyright © 2019 Adenilson Noronha da Silva Junior. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentedControlLevel: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createTask(_ sender: UIButton) {
        let name = textFieldName.text!
        if(name.isEmpty || name.isBlank) {
            showInvalidNameAlert()
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: datePicker.date)
        let level = segmentedControlLevel.selectedSegmentIndex + 1
        
        let user = Auth.auth().currentUser?.uid ?? ""
        let taskChildReference = Database.database().reference().child("tasks").child(user).childByAutoId()
        let task = Task(uid: taskChildReference.key ?? "", name: name, date: date, level: level, done: false)
        
        taskChildReference.setValue(Task.mapTaskToDictonary(task)) { error, reference in
            if (error == nil) {
                self.showSuccessAlert()
            } else {
                self.showErrorAlert()
            }
        }
        
    
    }
    
    func showInvalidNameAlert() {
        let alertViewController = UIAlertController(title: "Falha!", message: "Sua tarefa precisa ter um nome", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertViewController, animated: true, completion: nil)
    }
    
    func showSuccessAlert() {
        let alertViewController = UIAlertController(title: "Sucesso!", message: "Sua tarefa foi adicionada com sucesso", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        })
        present(alertViewController, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alertViewController = UIAlertController(title: "Falha!", message: "Não foi possível adicionar sua tarefa", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        })
        present(alertViewController, animated: true, completion: nil)
    }
}

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}
