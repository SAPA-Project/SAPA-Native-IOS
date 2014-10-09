//
//  InitialDemographicsViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/2/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class InitialDemographicsViewController: UIViewController {

    var userSettings: PFObject!
    
    var viewWidth: Double!
    var viewHeight: Double!
    
    @IBOutlet var yourBackgroundLabel: UILabel!
    @IBOutlet var facebookLabel: UILabel!
    @IBOutlet var twitterLabel: UILabel!
    
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var getStartedButton: UIButton!
    
    @IBOutlet var genderButton: UISegmentedControl!
    
    @IBOutlet var facebookSwitch: UISwitch!
    @IBOutlet var twitterSwitch: UISwitch!

    var loadMask: UIView!
    var activityIndicator: UIActivityIndicatorView!

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
        initializeLabels()
        initializeSwitches()
        initializeButtons()
        initializeTextFields()
        initializeActivityIndicator()
        
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
        
        let yourBackgroundLabelTopConstant = CGFloat(0.09445277361*viewHeight)
        let yourBackgroundLabelHeightMultiplier = CGFloat(0.09145427286)
        let yourBackgroundLabelWidthMultiplier = CGFloat(0.86666666666)
        
        let yourBackgroundLabelCenterXConstraint = NSLayoutConstraint(item: yourBackgroundLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let yourBackgroundLabelTopConstraint = NSLayoutConstraint(item: yourBackgroundLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: yourBackgroundLabelTopConstant)
        let yourBackgroundLabelHeightConstraint = NSLayoutConstraint(item: yourBackgroundLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: yourBackgroundLabelHeightMultiplier, constant: 0)
        let yourBackgroundLabelWidthConstraint = NSLayoutConstraint(item: yourBackgroundLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: yourBackgroundLabelWidthMultiplier, constant: 0)
        view.addConstraints([yourBackgroundLabelCenterXConstraint, yourBackgroundLabelTopConstraint, yourBackgroundLabelHeightConstraint, yourBackgroundLabelWidthConstraint])
        
        let facebookLabelLeadingConstant = CGFloat(0.31466666666*viewWidth)
        let facebookLabelTopConstant = CGFloat(0.41229385307*viewHeight)
        let facebookLabelHeightMultiplier = CGFloat(0.03148425787)
        let facebookLabelWidthMultiplier = CGFloat(0.26133333333)
        
        let facebookLabelLeadingConstraint = NSLayoutConstraint(item: facebookLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: facebookLabelLeadingConstant)
        let facebookLabelTopConstraint = NSLayoutConstraint(item: facebookLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: facebookLabelTopConstant)
        let facebookLabelHeightConstraint = NSLayoutConstraint(item: facebookLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: facebookLabelHeightMultiplier, constant: 0)
        let facebookLabelWidthConstraint = NSLayoutConstraint(item: facebookLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: facebookLabelWidthMultiplier, constant: 0)
        view.addConstraints([facebookLabelLeadingConstraint, facebookLabelTopConstraint, facebookLabelHeightConstraint, facebookLabelWidthConstraint])
        
        let twitterLabelLeadingConstant = CGFloat(0.31466666666*viewWidth)
        let twitterLabelTopConstant = CGFloat(0.50224887556*viewHeight)
        let twitterLabelHeightMultiplier = CGFloat(0.03148425787)
        let twitterLabelWidthMultiplier = CGFloat(0.26133333333)
        
        let twitterLabelLeadingConstraint = NSLayoutConstraint(item: twitterLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: twitterLabelLeadingConstant)
        let twitterLabelTopConstraint = NSLayoutConstraint(item: twitterLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: twitterLabelTopConstant)
        let twitterLabelHeightConstraint = NSLayoutConstraint(item: twitterLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: twitterLabelHeightMultiplier, constant: 0)
        let twitterLabelWidthConstraint = NSLayoutConstraint(item: twitterLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: twitterLabelWidthMultiplier, constant: 0)
        view.addConstraints([twitterLabelLeadingConstraint, twitterLabelTopConstraint, twitterLabelHeightConstraint, twitterLabelWidthConstraint])
        
    }
    
    func initializeButtons() {

        let enabledColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        let disabledColor = UIColor.lightGrayColor()
        
        let getStartedButtonTopConstant = CGFloat(0.60719640179*viewHeight)
        let buttonHeightMultiplier = CGFloat(0.07496251874)
        let buttonWidthMultiplier = CGFloat(0.608)
        
        getStartedButton.layer.borderWidth = 1.0
        getStartedButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        getStartedButton.setTitleColor(disabledColor, forState: .Disabled)
        getStartedButton.setTitleColor(enabledColor, forState: .Normal)
        getStartedButton.layer.cornerRadius = 5
        let getStartedButtonCenterXConstraint = NSLayoutConstraint(item: getStartedButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let getStartedButtonTopConstraint = NSLayoutConstraint(item: getStartedButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: getStartedButtonTopConstant)
        let getStartedButtonHeightConstraint = NSLayoutConstraint(item: getStartedButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let getStartedButtonWidthConstraint = NSLayoutConstraint(item: getStartedButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([getStartedButtonCenterXConstraint, getStartedButtonTopConstraint, getStartedButtonHeightConstraint, getStartedButtonWidthConstraint])
        getStartedButton.enabled = false


        let genderButtonTopConstant = CGFloat(0.22038980509*viewHeight)
        let genderButtonCenterXConstraint = NSLayoutConstraint(item: genderButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let genderButtonTopConstraint = NSLayoutConstraint(item: genderButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: genderButtonTopConstant)
        let genderButtonWidthConstraint = NSLayoutConstraint(item: genderButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([genderButtonCenterXConstraint, genderButtonTopConstraint, genderButtonWidthConstraint])
        
    }
    
    func initializeTextFields() {
        
        let ageTextFieldTopConstant = CGFloat(0.29835082458*viewHeight)
        let textFieldHeightMultiplier = CGFloat(0.07496251874)
        let textFieldWidthMultiplier = CGFloat(0.608)
        
        ageTextField.layer.borderWidth = 1.0
        ageTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        ageTextField.layer.cornerRadius = 3
        let ageTextFieldCenterXConstraint = NSLayoutConstraint(item: ageTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let ageTextFieldTopConstraint = NSLayoutConstraint(item: ageTextField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: ageTextFieldTopConstant)
        let ageTextFieldHeightConstraint = NSLayoutConstraint(item: ageTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let ageTextFieldWidthConstraint = NSLayoutConstraint(item: ageTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([ageTextFieldCenterXConstraint, ageTextFieldTopConstraint, ageTextFieldHeightConstraint, ageTextFieldWidthConstraint])
        ageTextField.addTarget(self, action: "checkIfFieldsEntered", forControlEvents: .EditingChanged)
        
    }
    
    func initializeSwitches() {
        
        let facebookSwitchLeadingConstant = CGFloat(0.59733333333*viewWidth)
        let facebookSwitchTopConstant = CGFloat(0.40629685157*viewHeight)
        let facebookSwitchHeightMultiplier = CGFloat(0.04647676161)
        let facebookSwitchWidthMultiplier = CGFloat(0.136)
        
        facebookSwitch.setOn(false, animated: false)
        let facebookSwitchLeadingConstraint = NSLayoutConstraint(item: facebookSwitch, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: facebookSwitchLeadingConstant)
        let facebookSwitchTopConstraint = NSLayoutConstraint(item: facebookSwitch, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: facebookSwitchTopConstant)
        let facebookSwitchHeightConstraint = NSLayoutConstraint(item: facebookSwitch, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: facebookSwitchHeightMultiplier, constant: 0)
        let facebookSwitchWidthConstraint = NSLayoutConstraint(item: facebookSwitch, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: facebookSwitchWidthMultiplier, constant: 0)
        view.addConstraints([facebookSwitchLeadingConstraint, facebookSwitchTopConstraint, facebookSwitchHeightConstraint, facebookSwitchWidthConstraint])
        
        let twitterSwitchLeadingConstant = CGFloat(0.59733333333*viewWidth)
        let twitterSwitchTopConstant = CGFloat(0.49475262368*viewHeight)
        let twitterSwitchHeightMultiplier = CGFloat(0.04647676161)
        let twitterSwitchWidthMultiplier = CGFloat(0.136)
        
        twitterSwitch.setOn(false, animated: false)
        let twitterSwitchLeadingConstraint = NSLayoutConstraint(item: twitterSwitch, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: twitterSwitchLeadingConstant)
        let twitterSwitchTopConstraint = NSLayoutConstraint(item: twitterSwitch, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: twitterSwitchTopConstant)
        let twitterSwitchHeightConstraint = NSLayoutConstraint(item: twitterSwitch, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: twitterSwitchHeightMultiplier, constant: 0)
        let twitterSwitchWidthConstraint = NSLayoutConstraint(item: twitterSwitch, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: twitterSwitchWidthMultiplier, constant: 0)
        view.addConstraints([twitterSwitchLeadingConstraint, twitterSwitchTopConstraint, twitterSwitchHeightConstraint, twitterSwitchWidthConstraint])
        
    }

    func initializeActivityIndicator() {
        loadMask = UIView(frame: CGRectMake(0,0,CGFloat(viewWidth),CGFloat(viewHeight))) as UIView
        loadMask.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 0.5)
        loadMask.center = view.center
        loadMask.hidden = true
        view.addSubview(loadMask)

        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0, 150, 150)) as UIActivityIndicatorView
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.color = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.addSubview(activityIndicator)
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

    func checkIfFieldsEntered() {
        if ageTextField.text != "" {
            enableGetStartedButton()
        }
        else {
            disableGetStartedButton()
        }
    }

    func enableGetStartedButton() {
        getStartedButton.layer.borderColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0).CGColor
        getStartedButton.enabled = true
    }

    func disableGetStartedButton() {
        getStartedButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        getStartedButton.enabled = false
    }

    @IBAction func didTapGetStarted() {

        self.view.endEditing(true)

        loadMask.hidden = false
        activityIndicator.startAnimating()

        var age = ageTextField.text.toInt()
        var gender = genderButton.titleForSegmentAtIndex(genderButton.selectedSegmentIndex)

        userSettings["age"] = age
        userSettings["gender"] = gender
        userSettings.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if success != nil {
                self.loadMask.hidden = true
                self.activityIndicator.stopAnimating()
                self.showMenuView()
            }
            else {
                self.loadMask.hidden = true
                self.activityIndicator.stopAnimating()
                NSLog("%@", error)
            }
        }

        showMenuView()

    }

    func showMenuView() {    
        //Prepare new view controller
        var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var newNavigationController = mainStoryboard.instantiateInitialViewController() as UINavigationController
        newNavigationController.modalTransitionStyle = .FlipHorizontal
        var rootViewController = newNavigationController.viewControllers[0] as MenuViewController
        rootViewController.userSettings = userSettings
        self.presentViewController(newNavigationController, animated: true, completion: nil)
           
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
//    func initializePicker() {
//        picker.hidden = true
//        genderPickerData = ["Male","Female"]
//    }
//    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return genderPickerData.count
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return genderPickerData[row] as String
//    }
//    
//    @IBAction func showPicker() {
//        picker.hidden = false
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
