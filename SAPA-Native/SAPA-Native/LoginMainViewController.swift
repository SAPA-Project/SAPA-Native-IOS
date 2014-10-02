//
//  ViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/1/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class LoginMainViewController: UIViewController {
    
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.hidden = true
        initializeButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeButtons() {
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0).CGColor
        signInButton.layer.cornerRadius = 5
        
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor
        signUpButton.layer.cornerRadius = 5
    }
    
    @IBAction func showSignInScreen() {
        let loginScreenViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginScreenViewController") as LoginScreenViewController
        self.navigationController?.pushViewController(loginScreenViewController, animated: true)
    }
    
    @IBAction func showSignUpScreen() {
        let signUpScreenViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpScreenViewController") as SignUpScreenViewController
        self.navigationController?.pushViewController(signUpScreenViewController, animated: true)
    }

}

