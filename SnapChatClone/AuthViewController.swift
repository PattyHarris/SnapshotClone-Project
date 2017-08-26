//
//  ViewController.swift
//  SnapChatClone
//
//  Created by Patty Harris on 8/24/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Nick switches the labels on this - TBD...
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
  
    // Indicates whether we're logging in or signing up.
    var loginMode : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelsAndText()
    }
    
    func setLabelsAndText() {
        if loginMode == true {
            topLabel.text = Storyboard.loginLabel
            topButton.setTitle(Storyboard.loginButton, for: .normal)
            
            bottomLabel.text = Storyboard.signUpLabel
            bottomButton.setTitle(Storyboard.signUpButton, for: .normal)
        }
        else {
            topLabel.text = Storyboard.signUpLabel
            topButton.setTitle(Storyboard.signUpButton, for: .normal)
            
            bottomLabel.text = Storyboard.loginLabel
            bottomButton.setTitle(Storyboard.loginButton, for: .normal)
        }
    }

    // Top button is either "login" or "sign up"
    @IBAction func topButtonDidTap(_ sender: Any) {
        
        // Unwrap the optionals as usual..
        if let email = emailTextField.text {
            
            if let password = passwordTextField.text {
                
                if loginMode == true {
                    // Login the user
                }
                else {
                    // Sign up the user
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
                        // Where user is FIRUser? and error is Error?
                        (user, error) in
                        
                        // Code called once the createUser function completes.
                        // Check first for an error
                        if let error = error {
                            print("An error occurred creating the user: \(error.localizedDescription)")
                        }
                        else {
                            // We were successful.
                            print("Success!")
                        }
                    })
                }

            }
        }
    }
    
    // Logic really doesn't make sense, but I'll go with it...
    // The Sign-up button, when the bottom button is supposed to
    // switch the text to allow the user to sign up using the text boxes.
    @IBAction func bottomButtonDidTap(_ sender: Any) {
        loginMode = !loginMode
        setLabelsAndText()
    }
    
    // Nested class Storyboard - used to set the text of the buttons and
    // labels.
    struct Storyboard {
        
        // Login label and button
        static let loginLabel = "Login to start using SnapChatClone!"
        static let loginButton = "Login"
        
        static let signUpLabel = "No account?  Sign up for free!"
        static let signUpButton = "Sign Up"
    }

}

