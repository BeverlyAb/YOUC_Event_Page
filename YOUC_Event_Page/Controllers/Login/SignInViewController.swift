//
//  SignInViewController.swift
//  YOUC_Event_Page
//
//  Created by Tejal Patel on 3/6/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sign In"
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    override func willMove(toParent parent: UIViewController?)
    {
        if parent == nil
        {
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
            } else {
                print("Error : \(error?.localizedDescription)")
                let alertController = UIAlertController(title: "YOUC", message:
                    "Username or Password is incorrect", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
