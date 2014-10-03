//
//  SignUpScreenViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/2/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class SignUpScreenViewController: UIViewController {

    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initializeButtons()
        initializeTextFields()
        
        let didTapView : Selector = "didTapView"
        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: didTapView)
        viewTapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(viewTapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapView() {
        self.view.endEditing(true)
    }
    
    func initializeButtons() {
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0).CGColor
        signUpButton.layer.cornerRadius = 5
    }
    
    func initializeTextFields() {
        
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        emailTextField.layer.cornerRadius = 5
        var emailTextFieldHeightConstraint = NSLayoutConstraint(item: emailTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 0.0, constant: 50.0)
        view.addConstraint(emailTextFieldHeightConstraint)
        
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        passwordTextField.layer.cornerRadius = 5
        var passwordTextFieldHeightConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 0.0, constant: 50.0)
        view.addConstraint(passwordTextFieldHeightConstraint)
        
        confirmPasswordTextField.layer.borderWidth = 1.0
        confirmPasswordTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        confirmPasswordTextField.layer.cornerRadius = 5
        var confirmPasswordTextFieldHeightConstraint = NSLayoutConstraint(item: confirmPasswordTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 0.0, constant: 50.0)
        view.addConstraint(confirmPasswordTextFieldHeightConstraint)
        
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        
        var color = CABasicAnimation(keyPath: "borderColor")
        color.fromValue = UIColor.lightGrayColor().CGColor
        color.toValue = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor
        
        var group = CAAnimationGroup()
        group.duration = 0.3
        group.animations = [color]
        textField.layer.addAnimation(group, forKey: "color")
        
        textField.layer.borderColor = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    @IBAction func showInitialDemographicsScreen() {
        let initialDemographicsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("InitialDemographicsViewController") as InitialDemographicsViewController
        self.navigationController?.pushViewController(initialDemographicsViewController, animated: true)
    }
    
    @IBAction func navigateBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
