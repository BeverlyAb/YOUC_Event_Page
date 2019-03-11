//
//  CreateAccountViewController.swift
//  YOUC_Event_Page
//
//  Created by Tejal Patel on 3/6/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailConfirmField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Create Account"
        
        usernameField.delegate = self
        passwordField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        emailConfirmField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func willMove(toParent parent: UIViewController?)
    {
        if parent == nil
        {
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    @IBAction func onCreateAccount(_ sender: Any) {
        if usernameField.text == "" || passwordField.text == "" || firstNameField.text == "" || lastNameField.text == "" || emailConfirmField.text == "" || emailField.text == ""{
            let alertController = UIAlertController(title: "YOUC", message:
                "Please enter information for all required fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else if self.emailField.text != self.emailConfirmField.text {
            let alertController = UIAlertController(title: "YOUC", message:
                "Emails do not match", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)

        } else {
            let user = PFUser()
            user.username = self.usernameField.text
            user.password = self.passwordField.text
            user["name"] = self.firstNameField.text!+" "+self.lastNameField.text!
            user.email = emailField.text
            user.signUpInBackground(block: { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "createAccountSegue", sender: nil)
                } else {
                    print("\(error?.localizedDescription)")
                }
            })
        }
    }
}
