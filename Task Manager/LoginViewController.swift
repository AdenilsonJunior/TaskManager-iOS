//
//  ViewController.swift
//  Task Manager
//
//  Created by Adenilson Noronha da Silva Junior on 13/09/19.
//  Copyright © 2019 Adenilson Noronha da Silva Junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func doLogin(_ sender: UIButton) {
        self.performSegue(withIdentifier: "TaskListSegue", sender: nil)
    }
}

