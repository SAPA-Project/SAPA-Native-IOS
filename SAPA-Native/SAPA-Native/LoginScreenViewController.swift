//
//  LoginScreenViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/1/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    var originalCenter: CGPoint!
    
    var viewWidth: Double!
    var viewHeight: Double!
    
    var keyboardPushedNewCenter: CGFloat!
    
    @IBOutlet var signInLabel: UILabel!
    
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Get screen size
        let screenRect = view.bounds
        let screenWidth = Double(screenRect.size.width)
        let screenHeight = Double(screenRect.size.height)
        viewWidth = screenWidth
        viewHeight = screenHeight
        
        //Initialize elements
        initializeButtons()
        initializeTextFields()
        initializeLabels()
        
        //Set keyboard height
        keyboardPushedNewCenter = CGFloat(viewHeight*0.24647887323)
        
        //Set screen center
        originalCenter = view.center
        
        //Hide keyboard on tap
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
    
    func initializeLabels() {
        
        let signInLabelTopConstant = CGFloat(0.26536731634*viewHeight)
        let signInLabelHeightMultiplier = CGFloat(0.14542728635)
        let signInLabelWidthMultiplier = CGFloat(0.86666666666)
        
        let signInLabelCenterXConstraint = NSLayoutConstraint(item: signInLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let signInLabelTopConstraint = NSLayoutConstraint(item: signInLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: signInLabelTopConstant)
        let signInLabelHeightConstraint = NSLayoutConstraint(item: signInLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: signInLabelHeightMultiplier, constant: 0)
        let signInLabelWidthConstraint = NSLayoutConstraint(item: signInLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: signInLabelWidthMultiplier, constant: 0)
        view.addConstraints([signInLabelCenterXConstraint, signInLabelTopConstraint, signInLabelHeightConstraint, signInLabelWidthConstraint])
        
    }
    
    func initializeButtons() {

        let enabledColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        let disabledColor = UIColor.lightGrayColor()
        
        let signInButtonTopConstant = CGFloat(0.61919040479*viewHeight)
        let buttonHeightMultiplier = CGFloat(0.07496251874)
        let buttonWidthMultiplier = CGFloat(0.608)
        
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        signInButton.setTitleColor(disabledColor, forState: .Disabled)
        signInButton.setTitleColor(enabledColor, forState: .Normal)
        signInButton.layer.cornerRadius = 5
        let signInButtonCenterXConstraint = NSLayoutConstraint(item: signInButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let signInButtonTopConstraint = NSLayoutConstraint(item: signInButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: signInButtonTopConstant)
        let signInButtonHeightConstraint = NSLayoutConstraint(item: signInButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let signInButtonWidthConstraint = NSLayoutConstraint(item: signInButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([signInButtonCenterXConstraint, signInButtonTopConstraint, signInButtonHeightConstraint, signInButtonWidthConstraint])
        signInButton.enabled = false

    }
    
    func initializeTextFields() {
        
        let emailTextFieldTopConstant = CGFloat(0.41079460269*viewHeight)
        let passwordTextFieldTopConstant = CGFloat(0.49925037481*viewHeight)
        let textFieldHeightMultiplier = CGFloat(0.07496251874)
        let textFieldWidthMultiplier = CGFloat(0.608)
        
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        emailTextField.layer.cornerRadius = 3
        let emailTextFieldCenterXConstraint = NSLayoutConstraint(item: emailTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let emailTextFieldTopConstraint = NSLayoutConstraint(item: emailTextField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: emailTextFieldTopConstant)
        let emailTextFieldHeightConstraint = NSLayoutConstraint(item: emailTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let emailTextFieldWidthConstraint = NSLayoutConstraint(item: emailTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([emailTextFieldCenterXConstraint, emailTextFieldTopConstraint, emailTextFieldHeightConstraint, emailTextFieldWidthConstraint])
        emailTextField.addTarget(self, action: "checkIfFieldsEntered", forControlEvents: .EditingChanged)
        
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        passwordTextField.layer.cornerRadius = 3
        let passwordTextFieldCenterXConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let passwordTextFieldTopConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: passwordTextFieldTopConstant)
        let passwordTextFieldHeightConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let passwordTextFieldWidthConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([passwordTextFieldCenterXConstraint, passwordTextFieldTopConstraint, passwordTextFieldHeightConstraint, passwordTextFieldWidthConstraint])
        passwordTextField.addTarget(self, action: "checkIfFieldsEntered", forControlEvents: .EditingChanged)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.25)
        view.center = CGPointMake(self.originalCenter.x, keyboardPushedNewCenter);
        UIView.commitAnimations()
        
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
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.25)
        view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y);
        UIView.commitAnimations()
        
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) {
        
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            textField.resignFirstResponder()
            logInUser()
        }
        
    }

    func checkIfFieldsEntered() {
        if emailTextField.text != "" && passwordTextField.text != "" {
            enableSignInButton()
        }
        else {
            disableSignUpButton()
        }
    }

    func enableSignInButton() {
        signInButton.layer.borderColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0).CGColor
        signInButton.enabled = true
    }

    func disableSignUpButton() {
        signInButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        signInButton.enabled = false
    }
    
    func logInUser() {
        
    }
    
    @IBAction func navigateBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
