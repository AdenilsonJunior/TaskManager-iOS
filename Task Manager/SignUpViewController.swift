//
//  SignUpViewController.swift
//  Task Manager
//
//  Created by Adenilson Noronha da Silva Junior on 13/09/19.
//  Copyright © 2019 Adenilson Noronha da Silva Junior. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doSignup(_ sender: UIButton) {
        let name = textFieldName.text!
        let email = textFieldEmail.text!
        let password = textFieldPassword.text!
        let confirmPassword = textFieldConfirmPassword.text!
        
        if(name.isBlank) {
            showAlert(title: "Falha!", message: "Nome inválido")
            return
        }
        if(email.isBlank) {
            showAlert(title: "Falha!", message: "Email inválido")
            return
        }
        if(password.isBlank) {
            showAlert(title: "Falha!", message: "Senha inválida")
            return
        }
        if(confirmPassword.isBlank) {
            showAlert(title: "Falha!", message: "Confirmação de senha inválida")
            return
        }
        if(password != confirmPassword) {
            showAlert(title: "Falha!", message: "As senhas não coincidem")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                self.showAlert(title: "Erro", message: "Ocorreu um erro ao tentar criar um usuário")
                return
            }
            self.createUserInDatabase(uid: user.uid, name: name, email: email)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func createUserInDatabase(uid: String, name: String, email: String) {
        Database.database().reference().child("users").childByAutoId().setValue(["uid": uid, "name": name, "email": email]) { error, reference in
            if(error == nil) {
                self.performSegue(withIdentifier: "TaskListSegue", sender: nil)
            } else {
                self.showAlert(title: "Error", message: "Ocorreu um erro ao tentar salvar informações do usuário")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
