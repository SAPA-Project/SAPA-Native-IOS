//
//  ProfileViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/9/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var userSettings: PFObject!

    var originalCenter: CGPoint!

    var keyboardPushedNewCenter: CGFloat!

    var viewWidth: Double!
    var viewHeight: Double!

    @IBOutlet var scroller: UIScrollView!

    @IBOutlet var scrollerInnerView: UIView!

    @IBOutlet var titlebar: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var titlebarTitle: UILabel!

    @IBOutlet var genderButton: UISegmentedControl!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var zipcodeTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var maritalStatusTextField: UITextField!
    @IBOutlet var relationshipStatusTextField: UITextField!
    @IBOutlet var exerciseTextField: UITextField!
    @IBOutlet var smokingTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!

    var pickerView: UIPickerView!
    var pickerData: NSArray!

    var currentTextField: String!

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
        keyboardPushedNewCenter = CGFloat(0.15478873239*viewHeight)
        
        //Set screen center
        originalCenter = view.center

        //Initialize elements
        initializeScroller()
        initializeTitlebar()
        initializeButtons()
        initializeTextFields()
        initializePicker()

        //Hide keyboard on tap
        let didTapView : Selector = "didTapView"
        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: didTapView)
        viewTapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(viewTapRecognizer)

        //Hide keyboard on touch drag
        // let longPressView: Selector = "longPressView:"
        // let viewDragRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressView:")
        // viewDragRecognizer.numberOfTapsRequired = 1
        // viewDragRecognizer.minimumPressDuration = 0.5
        // viewDragRecognizer.allowableMovement = 500.0
        // view.addGestureRecognizer(viewDragRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didTapView() {
        self.view.endEditing(true)
    }

    func longPressView(gestureRecognizer: UIGestureRecognizer) {
        NSLog("long press view")
        // self.view.endEditing(true)
    }

    func initializeScroller() {
        let scrollerHeight = CGFloat(viewHeight*0.88028169014)
        let scrollerWidth = CGFloat(viewWidth)
        scroller.contentSize = CGSizeMake(scrollerWidth,scrollerHeight)

        // let scrollerInnerViewHeightMultiplier = CGFloat(1.48591549296)
        let scrollerInnerViewWidthMultiplier = CGFloat(1.0)

        let scrollerInnerViewHeightConstraint = NSLayoutConstraint(item: scrollerInnerView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: 991.0)
        let scrollerInnerViewWidthConstraint = NSLayoutConstraint(item: scrollerInnerView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: scrollerInnerViewWidthMultiplier, constant: 0)
        view.addConstraints([scrollerInnerViewHeightConstraint, scrollerInnerViewWidthConstraint])

    }
    
    func initializeTitlebar() {

        let titlebarTopConstant = CGFloat(0)
        let titlebarHeightMultiplier = CGFloat(0.11971830985)
        let titlebarWidthMultiplier = CGFloat(1.0)
        let titlebarHeight = CGFloat(0.11971830985*viewHeight)
        let titlebarWidth = CGFloat(1.0*viewWidth)

        let menuButtonTopConstant = CGFloat(0.03873239436*viewHeight)
        let menuButtonHeightMultiplier = CGFloat(0.07218309859)
        let menuButtonWidthMultiplier = CGFloat(0.128125)

        let titlebarTitleTopConstant = CGFloat(0.05105633802*viewHeight)
        let titlebarTitleHeightMultiplier = CGFloat(0.04929577464)
        let titlebarTitleWidthMultiplier = CGFloat(0.55)

        let titlebarCenterXConstraint = NSLayoutConstraint(item: titlebar, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let titlebarTopConstraint = NSLayoutConstraint(item: titlebar, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: titlebarTopConstant)
        let titlebarHeightConstraint = NSLayoutConstraint(item: titlebar, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: titlebarHeightMultiplier, constant: 0)
        let titlebarWidthConstraint = NSLayoutConstraint(item: titlebar, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: titlebarWidthMultiplier, constant: 0)
        view.addConstraints([titlebarCenterXConstraint, titlebarTopConstraint, titlebarHeightConstraint, titlebarWidthConstraint])
        var titlebarBottomBorder = UIView(frame: CGRectMake(0, titlebarHeight - 1.0, titlebarWidth, 1))
        titlebarBottomBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        titlebar.addSubview(titlebarBottomBorder)

        let menuButtonLeadingConstraint = NSLayoutConstraint(item: menuButton, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let menuButtonTopConstraint = NSLayoutConstraint(item: menuButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: menuButtonTopConstant)
        let menuButtonHeightConstraint = NSLayoutConstraint(item: menuButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: menuButtonHeightMultiplier, constant: 0)
        let menuButtonWidthConstraint = NSLayoutConstraint(item: menuButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: menuButtonWidthMultiplier, constant: 0)
        view.addConstraints([menuButtonLeadingConstraint, menuButtonTopConstraint, menuButtonHeightConstraint, menuButtonWidthConstraint])

        let titlebarTitleCenterXConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let titlebarTitleTopConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: titlebarTitleTopConstant)
        let titlebarTitleHeightConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: titlebarTitleHeightMultiplier, constant: 0)
        let titlebarTitleWidthConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: titlebarTitleWidthMultiplier, constant: 0)
        view.addConstraints([titlebarTitleCenterXConstraint, titlebarTitleTopConstraint, titlebarTitleHeightConstraint, titlebarTitleWidthConstraint])
        
    }

    func initializeButtons() {
        
        let genderButtonTopConstant = CGFloat(0.0616197183*viewHeight)
        let buttonWidthMultiplier = CGFloat(0.640625)
        let genderButtonCenterXConstraint = NSLayoutConstraint(item: genderButton, attribute: .CenterX, relatedBy: .Equal, toItem: scrollerInnerView, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let genderButtonTopConstraint = NSLayoutConstraint(item: genderButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: genderButtonTopConstant)
        let genderButtonWidthConstraint = NSLayoutConstraint(item: genderButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([genderButtonCenterXConstraint, genderButtonWidthConstraint])
        genderButton.addTarget(self, action: "genderButtonChange", forControlEvents: .ValueChanged)

        let gender = userSettings["gender"] as String

        if gender == "Male" {
            genderButton.selectedSegmentIndex = 0
        }
        else {
            genderButton.selectedSegmentIndex = 1
        }

    }

    func initializeTextFields() {

        let textFieldHeightMultiplier = CGFloat(0.07496251874)
        let textFieldWidthMultiplier = CGFloat(0.640625)
        
        ageTextField.layer.borderWidth = 1.0
        ageTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        ageTextField.layer.cornerRadius = 3
        let ageTextFieldCenterXConstraint = NSLayoutConstraint(item: ageTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let ageTextFieldHeightConstraint = NSLayoutConstraint(item: ageTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let ageTextFieldWidthConstraint = NSLayoutConstraint(item: ageTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([ageTextFieldCenterXConstraint, ageTextFieldHeightConstraint, ageTextFieldWidthConstraint])

        zipcodeTextField.layer.borderWidth = 1.0
        zipcodeTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        zipcodeTextField.layer.cornerRadius = 3
        let zipcodeTextFieldCenterXConstraint = NSLayoutConstraint(item: zipcodeTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let zipcodeTextFieldHeightConstraint = NSLayoutConstraint(item: zipcodeTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let zipcodeTextFieldWidthConstraint = NSLayoutConstraint(item: zipcodeTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([zipcodeTextFieldCenterXConstraint, zipcodeTextFieldHeightConstraint, zipcodeTextFieldWidthConstraint])

        heightTextField.layer.borderWidth = 1.0
        heightTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        heightTextField.layer.cornerRadius = 3
        let heightTextFieldCenterXConstraint = NSLayoutConstraint(item: heightTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let heightTextFieldHeightConstraint = NSLayoutConstraint(item: heightTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let heightTextFieldWidthConstraint = NSLayoutConstraint(item: heightTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([heightTextFieldCenterXConstraint, heightTextFieldHeightConstraint, heightTextFieldWidthConstraint])

        weightTextField.layer.borderWidth = 1.0
        weightTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        weightTextField.layer.cornerRadius = 3
        let weightTextFieldCenterXConstraint = NSLayoutConstraint(item: weightTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let weightTextFieldHeightConstraint = NSLayoutConstraint(item: weightTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let weightTextFieldWidthConstraint = NSLayoutConstraint(item: weightTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([weightTextFieldCenterXConstraint, weightTextFieldHeightConstraint, weightTextFieldWidthConstraint])

        maritalStatusTextField.layer.borderWidth = 1.0
        maritalStatusTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        maritalStatusTextField.layer.cornerRadius = 3
        let maritalStatusTextFieldCenterXConstraint = NSLayoutConstraint(item: maritalStatusTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let maritalStatusTextFieldHeightConstraint = NSLayoutConstraint(item: maritalStatusTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let maritalStatusTextFieldWidthConstraint = NSLayoutConstraint(item: maritalStatusTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([maritalStatusTextFieldCenterXConstraint, maritalStatusTextFieldHeightConstraint, maritalStatusTextFieldWidthConstraint])

        relationshipStatusTextField.layer.borderWidth = 1.0
        relationshipStatusTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        relationshipStatusTextField.layer.cornerRadius = 3
        let relationshipStatusTextFieldCenterXConstraint = NSLayoutConstraint(item: relationshipStatusTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let relationshipStatusTextFieldHeightConstraint = NSLayoutConstraint(item: relationshipStatusTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let relationshipStatusTextFieldWidthConstraint = NSLayoutConstraint(item: relationshipStatusTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([relationshipStatusTextFieldCenterXConstraint, relationshipStatusTextFieldHeightConstraint, relationshipStatusTextFieldWidthConstraint])

        exerciseTextField.layer.borderWidth = 1.0
        exerciseTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        exerciseTextField.layer.cornerRadius = 3
        let exerciseTextFieldCenterXConstraint = NSLayoutConstraint(item: exerciseTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let exerciseTextFieldHeightConstraint = NSLayoutConstraint(item: exerciseTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let exerciseTextFieldWidthConstraint = NSLayoutConstraint(item: exerciseTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([exerciseTextFieldCenterXConstraint, exerciseTextFieldHeightConstraint, exerciseTextFieldWidthConstraint])

        smokingTextField.layer.borderWidth = 1.0
        smokingTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        smokingTextField.layer.cornerRadius = 3
        let smokingTextFieldCenterXConstraint = NSLayoutConstraint(item: smokingTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let smokingTextFieldHeightConstraint = NSLayoutConstraint(item: smokingTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let smokingTextFieldWidthConstraint = NSLayoutConstraint(item: smokingTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([smokingTextFieldCenterXConstraint, smokingTextFieldHeightConstraint, smokingTextFieldWidthConstraint])

        countryTextField.layer.borderWidth = 1.0
        countryTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        countryTextField.layer.cornerRadius = 3
        let countryTextFieldCenterXConstraint = NSLayoutConstraint(item: countryTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let countryTextFieldHeightConstraint = NSLayoutConstraint(item: countryTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let countryTextFieldWidthConstraint = NSLayoutConstraint(item: countryTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([countryTextFieldCenterXConstraint, countryTextFieldHeightConstraint, countryTextFieldWidthConstraint])

        stateTextField.layer.borderWidth = 1.0
        stateTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        stateTextField.layer.cornerRadius = 3
        let stateTextFieldCenterXConstraint = NSLayoutConstraint(item: stateTextField, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let stateTextFieldHeightConstraint = NSLayoutConstraint(item: stateTextField, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: textFieldHeightMultiplier, constant: 0)
        let stateTextFieldWidthConstraint = NSLayoutConstraint(item: stateTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: textFieldWidthMultiplier, constant: 0)
        view.addConstraints([stateTextFieldCenterXConstraint, stateTextFieldHeightConstraint, stateTextFieldWidthConstraint])

        let userAge = userSettings["age"] as Int
        let age = String(userAge)
        ageTextField.text = age

        if userSettings["zipcode"] != nil {
            let userZipcode = userSettings["zipcode"] as Int
            let zipcode = String(userZipcode)
            zipcodeTextField.text = zipcode
        }

        if userSettings["height"] != nil {
            heightTextField.text = userSettings["height"] as String
        }

        if userSettings["weight"] != nil {
            weightTextField.text = userSettings["weight"] as String
        }

        if userSettings["maritalStatus"] != nil {
            maritalStatusTextField.text = userSettings["maritalStatus"] as String
        }

        if userSettings["relationshipStatus"] != nil {
            relationshipStatusTextField.text = userSettings["relationshipStatus"] as String
        }

        if userSettings["exerciseFrequency"] != nil {
            exerciseTextField.text = userSettings["exerciseFrequency"] as String
        }

        if userSettings["smokingFrequency"] != nil {
            smokingTextField.text = userSettings["smokingFrequency"] as String
        }

        if userSettings["country"] != nil {
            countryTextField.text = userSettings["country"] as String
        }

        if userSettings["state"] != nil {
            stateTextField.text = userSettings["state"] as String
        }

    }

    func initializePicker() {
        pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.whiteColor()
        heightTextField.inputView = pickerView
        weightTextField.inputView = pickerView
        maritalStatusTextField.inputView = pickerView
        relationshipStatusTextField.inputView = pickerView
        exerciseTextField.inputView = pickerView
        smokingTextField.inputView = pickerView
        countryTextField.inputView = pickerView
        stateTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    func genderButtonChange() {
        let gender = genderButton.titleForSegmentAtIndex(genderButton.selectedSegmentIndex)
        userSettings["gender"] = gender
        userSettings.saveInBackground()
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
   
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row] as String
    }

    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == "height" {
            heightTextField.text = pickerData![row] as String
        }
        else if currentTextField == "weight" {
            weightTextField.text = pickerData![row] as String
        }
        else if currentTextField == "maritalStatus" {
            maritalStatusTextField.text = pickerData![row] as String
        }
        else if currentTextField == "relationshipStatus" {
            relationshipStatusTextField.text = pickerData![row] as String
        }
        else if currentTextField == "exercise" {
            exerciseTextField.text = pickerData![row] as String
        }
        else if currentTextField == "smoking" {
            smokingTextField.text = pickerData![row] as String
        }
        else if currentTextField == "country" {
            countryTextField.text = pickerData![row] as String
        }
        else if currentTextField == "state" {
            stateTextField.text = pickerData![row] as String
        }
    }

    func textFieldDidBeginEditing(textField: UITextField!) {

        let textFieldYPosition = Double(textField.frame.origin.y - scroller.contentOffset.y)

        if textFieldYPosition > viewHeight/3 {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.25)
            view.center = CGPointMake(self.originalCenter.x, keyboardPushedNewCenter);
            UIView.commitAnimations()
        }
        
        var color = CABasicAnimation(keyPath: "borderColor")
        color.fromValue = UIColor.lightGrayColor().CGColor
        color.toValue = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor
        
        var group = CAAnimationGroup()
        group.duration = 0.3
        group.animations = [color]
        textField.layer.addAnimation(group, forKey: "color")
        
        textField.layer.borderColor = UIColor(red: 0.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0).CGColor

        if textField == heightTextField {
            pickerData = HEIGHTOPTIONS
            currentTextField = "height"
        }
        else if textField == weightTextField {
            pickerData = WEIGHTOPTIONS
            currentTextField = "weight"
        }
        else if textField == maritalStatusTextField {
            pickerData = MARITALSTATUSOPTIONS
            currentTextField = "maritalStatus"
        }
        else if textField == relationshipStatusTextField {
            pickerData = RELATIONSHIPSTATUSOPTIONS
            currentTextField = "relationshipStatus"
        }
        else if textField == exerciseTextField {
            pickerData = EXERCISEOPTIONS
            currentTextField = "exercise"
        }
        else if textField == smokingTextField {
            pickerData = SMOKINGOPTIONS
            currentTextField = "smoking"
        }
        else if textField == countryTextField {
            pickerData = COUNTRYOPTIONS
            currentTextField = "country"
        }
        else if textField == stateTextField {
            pickerData = STATEOPTIONS
            currentTextField = "state"
        }

        pickerView.reloadAllComponents()

        if textField.text == "" && textField != ageTextField && textField != zipcodeTextField {
            textField.text = pickerData[0] as String
        }

    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        
        let textFieldYPosition = Double(textField.frame.origin.y - scroller.contentOffset.y)

        if textFieldYPosition > viewHeight/3 {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.25)
            view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y);
            UIView.commitAnimations()
        }
        
        textField.layer.borderColor = UIColor.lightGrayColor().CGColor

        if textField == ageTextField {
            userSettings["age"] = ageTextField.text.toInt()
        }
        else if textField == zipcodeTextField {
            userSettings["zipcode"] = zipcodeTextField.text.toInt()
        }   
        else if textField == heightTextField {
            userSettings["height"] = heightTextField.text
        } 
        else if textField == weightTextField {
            userSettings["weight"] = weightTextField.text
        } 
        else if textField == maritalStatusTextField {
            userSettings["maritalStatus"] = maritalStatusTextField.text
        } 
        else if textField == relationshipStatusTextField {
            userSettings["relationshipStatus"] = relationshipStatusTextField.text
        } 
        else if textField == exerciseTextField {
            userSettings["exerciseFrequency"] = exerciseTextField.text
        } 
        else if textField == smokingTextField {
            userSettings["smokingFrequency"] = smokingTextField.text
        } 
        else if textField == countryTextField {
            userSettings["country"] = countryTextField.text
        } 
        else if textField == stateTextField {
            userSettings["state"] = stateTextField.text
        } 

        userSettings.saveInBackground()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func navigateBack() {
        self.view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }

}
