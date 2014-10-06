//
//  SignUpScreenViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/2/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class SignUpScreenViewController: UIViewController {

    var originalCenter: CGPoint!
    
    var viewWidth: Double!
    var viewHeight: Double!
    
    var keyboardPushedNewCenter: CGFloat!
    
    @IBOutlet var signUpLabel: UILabel!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
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
        
        //Set keyboard height
        keyboardPushedNewCenter = CGFloat(0.21478873239*viewHeight)
        
        //Set screen center
        originalCenter = view.center
        
        //Initialize elements
        initializeLabels()
        initializeButtons()
        initializeTextFields()
        
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
        
        let signUpLabelTopConstant = CGFloat(0.17957746478*viewHeight)
        let signUpLabelHeightMultiplier = CGFloat(0.14542728635)
        let signUpLabelWidthMultiplier = CGFloat(0.86666666666)
        
        let signUpLabelCenterXConstraint = NSLayoutConstraint(item: signUpLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let signUpLabelTopConstraint = NSLayoutConstraint(item: signUpLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: signUpLabelTopConstant)
        let signUpLabelHeightConstraint = NSLayoutConstraint(item: signUpLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: signUpLabelHeightMultiplier, constant: 0)
        let signUpLabelWidthConstraint = NSLayoutConstraint(item: signUpLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: signUpLabelWidthMultiplier, constant: 0)
        view.addConstraints([signUpLabelCenterXConstraint, signUpLabelTopConstraint, signUpLabelHeightConstraint, signUpLabelWidthConstraint])
        
    }
    
    func initializeButtons() {

        let enabledColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        let disabledColor = UIColor.lightGrayColor()
        
        let signUpButtonTopConstant = CGFloat(0.72133802816*viewHeight)
        let buttonHeightMultiplier = CGFloat(0.07496251874)
        let buttonWidthMultiplier = CGFloat(0.608)

        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        signUpButton.setTitleColor(disabledColor, forState: .Disabled)
        signUpButton.setTitleColor(enabledColor, forState: .Normal)
        signUpButton.layer.cornerRadius = 5
        let signUpButtonCenterXConstraint = NSLayoutConstraint(item: signUpButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let signUpButtonTopConstraint = NSLayoutConstraint(item: signUpButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: signUpButtonTopConstant)
        let signUpButtonHeightConstraint = NSLayoutConstraint(item: signUpButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let signUpButtonWidthConstraint = NSLayoutConstraint(item: signUpButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([signUpButtonCenterXConstraint, signUpButtonTopConstraint, signUpButtonHeightConstraint, signUpButtonWidthConstraint])
        signUpButton.enabled = false

    }
    
    func initializeTextFields() {
        
        let emailTextFieldTopConstant = CGFloat(0.35915492957*viewHeight)
        let passwordTextFieldTopConstant = CGFloat(0.46302816901*viewHeight)
        let confirmPasswordTextFieldTopConstant = CGFloat(0.56690140845*viewHeight)
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

        confirmPasswordTextField.layer.borderWidth = 1.0
        confirmPasswordTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        confirmPasswordTextField.layer.cornerRadius = 3
        let confirmPasswordTextFieldCenterXConstraint = NSLayoutConstraint(item: confirmPasswordTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let confirmPasswordTextFieldTopConstraint = NSLayoutConstraint(item: confirmPasswordTextField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: confirmPasswordTextFieldTopConstant)
        let confirmPasswordTextFieldHeightConstraint = NSLayoutConstraint(item: confirmPasswordTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let confirmPasswordTextFieldWidthConstraint = NSLayoutConstraint(item: confirmPasswordTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([confirmPasswordTextFieldCenterXConstraint, confirmPasswordTextFieldTopConstraint, confirmPasswordTextFieldHeightConstraint, confirmPasswordTextFieldWidthConstraint])
        confirmPasswordTextField.addTarget(self, action: "checkIfFieldsEntered", forControlEvents: .EditingChanged)
        
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
            confirmPasswordTextField.becomeFirstResponder()
        }
        else if textField == confirmPasswordTextField {
            textField.resignFirstResponder()
            signUpUser()
        }
        
    }

    func checkIfFieldsEntered() {
        if emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != "" {
            enableSignUpButton()
        }
        else {
            disableSignUpButton()
        }
    }

    func enableSignUpButton() {
        signUpButton.layer.borderColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0).CGColor
        signUpButton.enabled = true
    }

    func disableSignUpButton() {
        signUpButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        signUpButton.enabled = false
    }

    @IBAction func didTapSignUp() {
        self.view.endEditing(true)
        signUpUser()
    }

    func signUpUser() {
        
        if passwordTextField.text != confirmPasswordTextField.text {
            var alert = UIAlertController(title: "Error", message: "Passwords don't match.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    func showInitialDemographicsScreen() {
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
