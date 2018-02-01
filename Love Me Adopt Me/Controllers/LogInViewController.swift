//
//  LogInViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class creates a log in and register view. The user has to log in with email and password, if he already has an account. Otherwise he has to register as new user. After registering, he will be logged in automatically. For this class is some code used of James Dacombe: https://appcoda.com/firebase-login-signup/ and David East: https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LogInViewController: UIViewController {

    // Constants
    let loginToList = "LoginToList"
    
    // Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    // Loads view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks whether user is logged in or not
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
            }
        }
    }
    
    // Actions
    // Button for Login
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        
        // Checks if textfields are empty. If empty: alerts user
        if self.textFieldLoginEmail.text == "" || self.textFieldLoginPassword.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        
        // Checks if user is recognized by Firebase
        } else {
            Auth.auth().signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!) { user, error in
            
                // If login is OK, segue to LoveMeViewController
                if error == nil {
                    self.performSegue(withIdentifier: self.loginToList, sender: nil)
                
                // If login failed, alert for user an error occured
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // Button for Register
    @IBAction func registerDidTouch(_ sender: AnyObject) {
        // Defines content of alerts
        let alert = UIAlertController(title: "Register",
                                      message: "Please enter your email and password",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
                                   
            // Checks if textfields are empty
            if emailField.text == "" || passwordField.text == "" {
                
                // Defines content of alert
                let alertController = UIAlertController(title: "Error",
                                                        message: "Please enter your email and password",
                                                        preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK",
                                                  style: .cancel,
                                                  handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            
            // Checks if given user data does not already exist in Firebase
            } else {
                Auth.auth().createUser(withEmail: emailField.text!,
                                       password: passwordField.text!) { user, error in
                                        
                    // Stores user data in Firebase and performs login
                    if error == nil {
                        self.storeUserData(userId: (user?.uid)!)
                        Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
                                           password: self.textFieldLoginPassword.text!)
                    }
                }
            }
        }
        
        // Defines content of alerts
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Stores new user in Firebase when registering
    func storeUserData(userId: String) {
        Database.database().reference().child("all-users").child(userId).setValue([
            "email": Auth.auth().currentUser?.email,
            "uid": Auth.auth().currentUser?.uid
            ])
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    // Checks for content in textfields, setting first responders
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        } else if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

