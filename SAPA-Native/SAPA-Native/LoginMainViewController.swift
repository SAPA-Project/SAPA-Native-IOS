//
//  ViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/1/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class LoginMainViewController: UIViewController {
    
    var viewWidth: Double!
    var viewHeight: Double!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var taglineLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let screenRect = view.bounds
        let screenWidth = Double(screenRect.size.width)
        let screenHeight = Double(screenRect.size.height)
        viewWidth = screenWidth
        viewHeight = screenHeight
        
        self.navigationController?.navigationBar.hidden = true
        
        initializeLabels()
        initializeButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeLabels() {
        
        let titleLabelTopConstant = CGFloat(0.27586206896*viewHeight)
        let taglineLabelTopConstant = CGFloat(0.43328335832*viewHeight)
        let titleLabelHeightMultiplier = CGFloat(0.14542728635)
        let titleLabelWidthMultiplier = CGFloat(0.86666666666)
        let taglineLabelHeightMultiplier = CGFloat(0.05148425787)
        let taglineLabelWidthMultiplier = CGFloat(0.72)
        
        let titleLabelCenterXConstraint = NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let titleLabelTopConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: titleLabelTopConstant)
        let titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: titleLabelHeightMultiplier, constant: 0)
        let titleLabelWidthConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: titleLabelWidthMultiplier, constant: 0)
        view.addConstraints([titleLabelCenterXConstraint, titleLabelTopConstraint, titleLabelHeightConstraint, titleLabelWidthConstraint])
        
        let taglineLabelCenterXConstraint = NSLayoutConstraint(item: taglineLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let taglineLabelTopConstraint = NSLayoutConstraint(item: taglineLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: taglineLabelTopConstant)
        let taglineLabelHeightConstraint = NSLayoutConstraint(item: taglineLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: taglineLabelHeightMultiplier, constant: 0)
        let taglineLabelWidthConstraint = NSLayoutConstraint(item: taglineLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: taglineLabelWidthMultiplier, constant: 0)
        view.addConstraints([taglineLabelCenterXConstraint, taglineLabelTopConstraint, taglineLabelHeightConstraint, taglineLabelWidthConstraint])
        
    }
    
    func initializeButtons() {
        
        let signInButtonTopConstant = CGFloat(0.52023988006*viewHeight)
        let signUpButtonTopConstant = CGFloat(0.62518740629*viewHeight)
        let buttonHeightMultiplier = CGFloat(0.07496251874)
        let buttonWidthMultiplier = CGFloat(0.608)
        
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0).CGColor
        signInButton.layer.cornerRadius = 5
        let signInButtonCenterXConstraint = NSLayoutConstraint(item: signInButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let signInButtonTopConstraint = NSLayoutConstraint(item: signInButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: signInButtonTopConstant)
        let signInButtonHeightConstraint = NSLayoutConstraint(item: signInButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let signInButtonWidthConstraint = NSLayoutConstraint(item: signInButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([signInButtonCenterXConstraint, signInButtonTopConstraint, signInButtonHeightConstraint, signInButtonWidthConstraint])
        
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor
        signUpButton.layer.cornerRadius = 5
        let signUpButtonCenterXConstraint = NSLayoutConstraint(item: signUpButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let signUpButtonTopConstraint = NSLayoutConstraint(item: signUpButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: signUpButtonTopConstant)
        let signUpButtonHeightConstraint = NSLayoutConstraint(item: signUpButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let signUpButtonWidthConstraint = NSLayoutConstraint(item: signUpButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([signUpButtonCenterXConstraint, signUpButtonTopConstraint, signUpButtonHeightConstraint, signUpButtonWidthConstraint])
        
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

