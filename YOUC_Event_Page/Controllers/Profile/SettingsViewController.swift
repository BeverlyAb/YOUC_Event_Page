//
//  SettingsViewController.swift
//  YOUC_Event_Page
//
//  Created by Hermain Hanif on 3/11/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()!
        firstNameField.text = user["name"] as! String
        emailField.text = user["email"] as! String
        usernameField.text = user.username
        passwordField.text = user.password
        

        // Do any additional setup after loading the view.
    }
    //hides the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }
    
    @IBAction func onSave(_ sender: Any) {
        let user = PFUser.current()!
        user["name"] = firstNameField.text
        user["email"] = emailField.text
        user.username = usernameField.text
        user.password = passwordField.text
        user.saveInBackground { (success, error) in
            if success {
                print("changes saved")
            } else {
                print("changes not saved")
            }
        }
        reloadInputViews()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
