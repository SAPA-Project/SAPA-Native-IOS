//
//  ProfileViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/9/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var userSettings: PFObject!

    var originalCenter: CGPoint!

    var keyboardPushedNewCenter: CGFloat!

    var viewWidth: Double!
    var viewHeight: Double!

    var scrollView: UIScrollView!

    @IBOutlet var titlebar: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var titlebarTitle: UILabel!

    var genderButton: UISegmentedControl!
    var ageTextField: UITextField!
    var zipcodeTextField: UITextField!
    var heightTextField: UITextField!
    var weightTextField: UITextField!
    var maritalStatusTextField: UITextField!
    var relationshipStatusTextField: UITextField!
    var exerciseTextField: UITextField!
    var smokingTextField: UITextField!
    var countryTextField: UITextField!
    var stateTextField: UITextField!

    var facebookSwitch: UISwitch!
    var twitterSwitch: UISwitch!

    var pickerView: UIPickerView!
    var pickerData: NSArray!

    var currentListItemHeight: CGFloat!

    var currentTextField: String!

    var currentRow: Int!

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
        keyboardPushedNewCenter = CGFloat(40.0)
        
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

    func initializeScroller() {
        let scrollViewHeight = CGFloat(viewHeight)
        let scrollViewWidth = CGFloat(viewWidth)
        let scrollableHeight = CGFloat(1475.0)
        let scrollViewTopConstant = CGFloat(64.0)
        scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0,scrollViewTopConstant,scrollViewWidth,scrollViewHeight)
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollEnabled = true
        scrollView.userInteractionEnabled = true
        scrollView.keyboardDismissMode = .OnDrag
        scrollView.contentSize = CGSizeMake(scrollViewWidth,scrollableHeight)
        view.addSubview(scrollView)
        currentListItemHeight = CGFloat(0.0)
    }
    
    func initializeTitlebar() {

        let titlebarTopConstant = CGFloat(0)
        let titlebarHeightConstant = CGFloat(64.0)
        let titlebarWidthMultiplier = CGFloat(1.0)
        let titlebarHeight = CGFloat(64.0)
        let titlebarWidth = CGFloat(1.0*viewWidth)

        let menuButtonTopConstant = CGFloat(22.0)
        let menuButtonHeightConstant = CGFloat(41.0)
        let menuButtonWidthConstant = CGFloat(41.0)

        let titlebarTitleTopConstant = CGFloat(10.0)
        let titlebarTitleHeightConstant = CGFloat(28.0)
        let titlebarTitleWidthMultiplier = CGFloat(0.55)

        let titlebarCenterXConstraint = NSLayoutConstraint(item: titlebar, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let titlebarTopConstraint = NSLayoutConstraint(item: titlebar, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: titlebarTopConstant)
        let titlebarHeightConstraint = NSLayoutConstraint(item: titlebar, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: titlebarHeightConstant)
        let titlebarWidthConstraint = NSLayoutConstraint(item: titlebar, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: titlebarWidthMultiplier, constant: 0)
        view.addConstraints([titlebarCenterXConstraint, titlebarTopConstraint, titlebarHeightConstraint, titlebarWidthConstraint])
        var titlebarBottomBorder = UIView(frame: CGRectMake(0, titlebarHeight - 1.0, titlebarWidth, 1))
        titlebarBottomBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        titlebar.addSubview(titlebarBottomBorder)

        let menuButtonLeadingConstraint = NSLayoutConstraint(item: menuButton, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let menuButtonTopConstraint = NSLayoutConstraint(item: menuButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: menuButtonTopConstant)
        let menuButtonHeightConstraint = NSLayoutConstraint(item: menuButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: menuButtonHeightConstant)
        let menuButtonWidthConstraint = NSLayoutConstraint(item: menuButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.0, constant: menuButtonWidthConstant)
        view.addConstraints([menuButtonLeadingConstraint, menuButtonTopConstraint, menuButtonHeightConstraint, menuButtonWidthConstraint])

        let titlebarTitleCenterXConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let titlebarTitleTopConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: titlebarTitleTopConstant)
        let titlebarTitleHeightConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.0, constant: titlebarHeightConstant)
        let titlebarTitleWidthConstraint = NSLayoutConstraint(item: titlebarTitle, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: titlebarTitleWidthMultiplier, constant: 0)
        view.addConstraints([titlebarTitleCenterXConstraint, titlebarTitleTopConstraint, titlebarTitleHeightConstraint, titlebarTitleWidthConstraint])
        
    }

    func initializeButtons() {

        let cellHeight = CGFloat(65.0)
        let cellWidth = CGFloat(viewWidth)
        
        var cell = UIView()
        cell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(cell)

        let genderButtonLeadingConstant = CGFloat((viewWidth - 230)/2)
        let genderButtonTopConstant = CGFloat(18.0)
        let genderButtonWidth = CGFloat(230.0)
        
        genderButton = UISegmentedControl(items: ["Male", "Female"])
        genderButton.frame = CGRectMake(genderButtonLeadingConstant, genderButtonTopConstant, genderButtonWidth, 29.0)
        genderButton.addTarget(self, action: "genderButtonChange", forControlEvents: .ValueChanged)

        cell.addSubview(genderButton)

        currentListItemHeight = currentListItemHeight + cellHeight

        let gender = userSettings["gender"] as String

        if gender == "Male" {
            genderButton.selectedSegmentIndex = 0
        }
        else {
            genderButton.selectedSegmentIndex = 1
        }

    }

    func initializeTextFields() {

        let cellHeight = CGFloat(65.0)
        let cellWidth = CGFloat(viewWidth)
        
        var ageCell = UIView()
        ageCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(ageCell)

        let textFieldLeadingConstant = CGFloat((viewWidth - 230)/2)
        let textFieldTopConstant = CGFloat(13.0)
        let textFieldHeight = CGFloat(39.0)
        let textFieldWidth = CGFloat(230.0)
        
        //age
        ageTextField = UITextField()
        ageTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        ageTextField.layer.borderWidth = 1.0
        ageTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        ageTextField.layer.cornerRadius = 3
        ageTextField.textAlignment = .Center
        ageTextField.placeholder = "Age"
        ageTextField.delegate = self

        ageCell.addSubview(ageTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //zipcode
        var zipcodeCell = UIView()
        zipcodeCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(zipcodeCell)

        zipcodeTextField = UITextField()
        zipcodeTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        zipcodeTextField.layer.borderWidth = 1.0
        zipcodeTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        zipcodeTextField.layer.cornerRadius = 3
        zipcodeTextField.textAlignment = .Center
        zipcodeTextField.placeholder = "Zipcode"
        zipcodeTextField.delegate = self

        zipcodeCell.addSubview(zipcodeTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //facebook
        var facebookCell = UIView()
        facebookCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(facebookCell)

        let facebookLabelLeadingConstant = CGFloat(85.0)
        let facebookLabelTopConstant = CGFloat(22.0)
        let facebookLabelWidth = CGFloat(100.0)
        let facebookLabelHeight = CGFloat(21.0)

        var facebookLabel = UILabel()
        facebookLabel.frame = CGRectMake(facebookLabelLeadingConstant, facebookLabelTopConstant, facebookLabelWidth, facebookLabelHeight)
        facebookLabel.text = "Facebook"
        facebookLabel.textColor = UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 1.0)

        facebookCell.addSubview(facebookLabel)

        let switchLeadingConstant = CGFloat(viewWidth - 80 - 51)
        let switchTopConstant = CGFloat(17.0)
        let switchWidth = CGFloat(51.0)
        let switchHeight = CGFloat(31.0)

        facebookSwitch = UISwitch()
        facebookSwitch.frame = CGRectMake(switchLeadingConstant, switchTopConstant, switchWidth, switchHeight)
        facebookSwitch.on = userSettings["facebookConnected"] as Bool
        facebookSwitch.addTarget(self, action: "didToggleFacebookSwitch", forControlEvents: .ValueChanged)

        facebookCell.addSubview(facebookSwitch)

        currentListItemHeight = currentListItemHeight + cellHeight

        //twitter
        var twitterCell = UIView()
        twitterCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(twitterCell)

        let twitterLabelLeadingConstant = CGFloat(85.0)
        let twitterLabelTopConstant = CGFloat(22.0)
        let twitterLabelWidth = CGFloat(100.0)
        let twitterLabelHeight = CGFloat(21.0)

        var twitterLabel = UILabel()
        twitterLabel.frame = CGRectMake(twitterLabelLeadingConstant, twitterLabelTopConstant, twitterLabelWidth, twitterLabelHeight)
        twitterLabel.text = "Twitter"
        twitterLabel.textColor = UIColor(red: 0.0/255.0, green: 172.0/255.0, blue: 237.0/255.0, alpha: 1.0)

        twitterCell.addSubview(twitterLabel)

        twitterSwitch = UISwitch()
        twitterSwitch.frame = CGRectMake(switchLeadingConstant, switchTopConstant, switchWidth, switchHeight)
        twitterSwitch.on = userSettings["twitterConnected"] as Bool
        twitterSwitch.addTarget(self, action: "didToggleTwitterSwitch", forControlEvents: .ValueChanged)

        twitterCell.addSubview(twitterSwitch)

        currentListItemHeight = currentListItemHeight + cellHeight

        //height
        var heightCell = UIView()
        heightCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(heightCell)

        heightTextField = UITextField()
        heightTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        heightTextField.layer.borderWidth = 1.0
        heightTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        heightTextField.layer.cornerRadius = 3
        heightTextField.textAlignment = .Center
        heightTextField.placeholder = "Height"
        heightTextField.delegate = self

        heightCell.addSubview(heightTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //weight
        var weightCell = UIView()
        weightCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(weightCell)

        weightTextField = UITextField()
        weightTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        weightTextField.layer.borderWidth = 1.0
        weightTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        weightTextField.layer.cornerRadius = 3
        weightTextField.textAlignment = .Center
        weightTextField.placeholder = "Weight"
        weightTextField.delegate = self

        weightCell.addSubview(weightTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //maritalStatus
        var maritalStatusCell = UIView()
        maritalStatusCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(maritalStatusCell)

        maritalStatusTextField = UITextField()
        maritalStatusTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        maritalStatusTextField.layer.borderWidth = 1.0
        maritalStatusTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        maritalStatusTextField.layer.cornerRadius = 3
        maritalStatusTextField.textAlignment = .Center
        maritalStatusTextField.placeholder = "Marital status"
        maritalStatusTextField.delegate = self

        maritalStatusCell.addSubview(maritalStatusTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //relationshipStatus
        var relationshipStatusCell = UIView()
        relationshipStatusCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(relationshipStatusCell)

        relationshipStatusTextField = UITextField()
        relationshipStatusTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        relationshipStatusTextField.layer.borderWidth = 1.0
        relationshipStatusTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        relationshipStatusTextField.layer.cornerRadius = 3
        relationshipStatusTextField.textAlignment = .Center
        relationshipStatusTextField.placeholder = "Relationship status"
        relationshipStatusTextField.delegate = self

        relationshipStatusCell.addSubview(relationshipStatusTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //exercise
        var exerciseCell = UIView()
        exerciseCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(exerciseCell)

        exerciseTextField = UITextField()
        exerciseTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        exerciseTextField.layer.borderWidth = 1.0
        exerciseTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        exerciseTextField.layer.cornerRadius = 3
        exerciseTextField.textAlignment = .Center
        exerciseTextField.placeholder = "How often do you exercise?"
        exerciseTextField.delegate = self

        exerciseCell.addSubview(exerciseTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //smoking
        var smokingCell = UIView()
        smokingCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(smokingCell)

        smokingTextField = UITextField()
        smokingTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        smokingTextField.layer.borderWidth = 1.0
        smokingTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        smokingTextField.layer.cornerRadius = 3
        smokingTextField.textAlignment = .Center
        smokingTextField.placeholder = "How often do you smoke?"
        smokingTextField.delegate = self

        smokingCell.addSubview(smokingTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //country
        var countryCell = UIView()
        countryCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(countryCell)

        countryTextField = UITextField()
        countryTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        countryTextField.layer.borderWidth = 1.0
        countryTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        countryTextField.layer.cornerRadius = 3
        countryTextField.textAlignment = .Center
        countryTextField.placeholder = "Country"
        countryTextField.delegate = self

        countryCell.addSubview(countryTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

        //state
        var stateCell = UIView()
        stateCell.frame = CGRectMake(0, currentListItemHeight, cellWidth, cellHeight)
        scrollView.addSubview(stateCell)

        stateTextField = UITextField()
        stateTextField.frame = CGRectMake(textFieldLeadingConstant, textFieldTopConstant, textFieldWidth, textFieldHeight)
        stateTextField.layer.borderWidth = 1.0
        stateTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        stateTextField.layer.cornerRadius = 3
        stateTextField.textAlignment = .Center
        stateTextField.placeholder = "State (USA only)"
        stateTextField.delegate = self

        stateCell.addSubview(stateTextField)

        currentListItemHeight = currentListItemHeight + cellHeight

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

    func didToggleFacebookSwitch() {
        let facebookSwitchState = facebookSwitch.on
        userSettings["facebookConnected"] = facebookSwitchState
        userSettings.saveInBackground()

        if facebookSwitchState {
            // Open a session showing the user the login UI
            // You must ALWAYS ask for public_profile permissions when opening a session
            var permissions = ["public_profile"]
            var controller = self
            FBSession.openActiveSessionWithReadPermissions(permissions, allowLoginUI: true, completionHandler: {
                (session: FBSession!, state: FBSessionState!, error: NSError!) -> Void in

                // Retrieve the app delegate
                var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
                appDelegate.sessionStateChanged(session, state: state, error: error)

            })
        }
        else {
            FBSession.activeSession().closeAndClearTokenInformation()
        }
    }

    func didToggleTwitterSwitch() {
        let twitterSwitchState = facebookSwitch.on
        userSettings["twitterConnected"] = twitterSwitchState
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
        currentRow = row
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

        let absoluteframe = textField.convertRect(textField.frame, toView: UIApplication.sharedApplication().keyWindow)
        // [mytextfield convertRect:mytextfield.frame toView:[UIApplication sharedApplication].keyWindow]

        let textFieldYPosition = Double(absoluteframe.origin.y)

        NSLog("%f", textFieldYPosition)

        if textFieldYPosition > viewHeight/2 {
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

        currentRow = 0

        pickerView.reloadAllComponents()

        if textField.text == "" && textField != ageTextField && textField != zipcodeTextField {
            textField.text = pickerData[0] as String
        }

    }
    
    func textFieldDidEndEditing(textField: UITextField!) {

        if view.center == CGPointMake(self.originalCenter.x, keyboardPushedNewCenter) {
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
            userSettings["heightNumber"] = HEIGHTVALUES[currentRow]
            userSettings["height"] = heightTextField.text
        } 
        else if textField == weightTextField {
            userSettings["weightNumber"] = WEIGHTVALUES[currentRow]
            userSettings["weight"] = weightTextField.text
        } 
        else if textField == maritalStatusTextField {
            userSettings["maritalStatusNumber"] = MARITALSTATUSVALUES[currentRow]
            userSettings["maritalStatus"] = maritalStatusTextField.text
        } 
        else if textField == relationshipStatusTextField {
            userSettings["relationshipStatusNumber"] = RELATIONSHIPSTATUSVALUES[currentRow]
            userSettings["relationshipStatus"] = relationshipStatusTextField.text
        } 
        else if textField == exerciseTextField {
            userSettings["exerciseFrequencyNumber"] = EXERCISEVALUES[currentRow]
            userSettings["exerciseFrequency"] = exerciseTextField.text
        } 
        else if textField == smokingTextField {
            userSettings["smokingFrequencyNumber"] = SMOKINGVALUES[currentRow]
            userSettings["smokingFrequency"] = smokingTextField.text
        } 
        else if textField == countryTextField {
            userSettings["countryNumber"] = currentRow + 1
            userSettings["country"] = countryTextField.text
        } 
        else if textField == stateTextField {
            userSettings["stateNumber"] = currentRow + 1
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
