//
//  ViewController.swift
//  Task Manager
//
//  Created by Adenilson Noronha da Silva Junior on 13/09/19.
//  Copyright © 2019 Adenilson Noronha da Silva Junior. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        Auth.auth().signIn(withEmail: textFieldEmail.text!, password: textFieldPassword.text!) { result, error in
            if(error == nil && result?.user != nil) {
                self.performSegue(withIdentifier: "TaskListSegue", sender: nil)
            } else {
                self.showInvalidLogin()
            }
        }
    }
    
    func showInvalidLogin() {
        let alertViewController = UIAlertController(title: "Error!", message: "Email ou senha inválido.", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
}

