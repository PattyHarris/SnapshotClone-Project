//
//  ViewController.swift
//  SnapChatClone
//
//  Created by Patty Harris on 8/24/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Nick switches the labels on this - TBD...
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
  
    // Indicates whether we're logging in or signing up.
    var loginMode : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelsAndText()
    }
    
    func setLabelsAndText() {
        if loginMode == true {
            topLabel.text = Storyboard.loginLabel
            topButton.titleLabel?.text = Storyboard.loginButton
            
            bottomLabel.text = Storyboard.signUpLabel
            bottomButton.titleLabel?.text = Storyboard.signUpButton
        }
        else {
            topLabel.text = Storyboard.signUpLabel
            topButton.titleLabel?.text = Storyboard.signUpButton
            
            bottomLabel.text = Storyboard.loginLabel
            bottomButton.titleLabel?.text = Storyboard.loginButton
        }
    }

    @IBAction func topButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func bottomButtonDidTap(_ sender: Any) {
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

