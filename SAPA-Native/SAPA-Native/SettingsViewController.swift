//
//  SettingsViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/13/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var userSettings: PFObject!

    var originalCenter: CGPoint!

    var keyboardPushedNewCenter: CGFloat!

    var viewWidth: Double!
    var viewHeight: Double!

    @IBOutlet var titlebar: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var titlebarTitle: UILabel!

    @IBOutlet var emailLabel: UILabel!

    @IBOutlet var notificationLabel: UILabel!

    @IBOutlet var cell1: UIView!
    @IBOutlet var cell2: UIView!
    @IBOutlet var cell3: UIView!
    @IBOutlet var cell4: UIView!

    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var frequencyLabel: UILabel!
    @IBOutlet var questionsLabel: UILabel!

    @IBOutlet var startTimeTextField: UITextField!
    @IBOutlet var endTimeTextField: UITextField!
    @IBOutlet var frequencyTextField: UITextField!
    @IBOutlet var questionsTextField: UITextField!

    var currentTextField: String!

    var currentStartTime: NSDate!
    var currentEndTime: NSDate!

    var datePicker: UIDatePicker!

    @IBOutlet var logOutButton: UIButton!

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
        keyboardPushedNewCenter = CGFloat(0.35478873239*viewHeight)
        
        //Set screen center
        originalCenter = view.center

        //Initialize elements
        initializeTitlebar()
        initializeCells()
        initializeLabels()
        initializeTextFields()
        initializeButtons()

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

    func initializeCells() {

        let cell1TopConstant = CGFloat(0.36443661971*viewHeight)
        let cell2TopConstant = CGFloat(0.46126760563*viewHeight)
        let cell3TopConstant = CGFloat(0.55809859154*viewHeight)
        let cell4TopConstant = CGFloat(0.65492957746*viewHeight)
        
        let cellWidthMultiplier = CGFloat(1.0)
        let cellHeightMultiplier = CGFloat(0.09154929577)
        
        let cellWidth = CGFloat(viewWidth)
        let cellHeight = CGFloat(0.09154929577*viewHeight)

        let cell1CenterXConstraint = NSLayoutConstraint(item: cell1, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let cell1TopConstraint = NSLayoutConstraint(item: cell1, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: cell1TopConstant)
        let cell1HeightConstraint = NSLayoutConstraint(item: cell1, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: cellHeightMultiplier, constant: 0)
        let cell1WidthConstraint = NSLayoutConstraint(item: cell1, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellWidthMultiplier, constant: 0)
        view.addConstraints([cell1CenterXConstraint, cell1TopConstraint, cell1HeightConstraint, cell1WidthConstraint])
        var cell1TopBorder = UIView(frame: CGRectMake(0, 0, cellWidth, 1))
        cell1TopBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        cell1.addSubview(cell1TopBorder)

        let cell2CenterXConstraint = NSLayoutConstraint(item: cell2, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let cell2TopConstraint = NSLayoutConstraint(item: cell2, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: cell2TopConstant)
        let cell2HeightConstraint = NSLayoutConstraint(item: cell2, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: cellHeightMultiplier, constant: 0)
        let cell2WidthConstraint = NSLayoutConstraint(item: cell2, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellWidthMultiplier, constant: 0)
        view.addConstraints([cell2CenterXConstraint, cell2TopConstraint, cell2HeightConstraint, cell2WidthConstraint])
        var cell2TopBorder = UIView(frame: CGRectMake(0, 0, cellWidth, 1))
        cell2TopBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        cell2.addSubview(cell2TopBorder)

        let cell3CenterXConstraint = NSLayoutConstraint(item: cell3, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let cell3TopConstraint = NSLayoutConstraint(item: cell3, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: cell3TopConstant)
        let cell3HeightConstraint = NSLayoutConstraint(item: cell3, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: cellHeightMultiplier, constant: 0)
        let cell3WidthConstraint = NSLayoutConstraint(item: cell3, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellWidthMultiplier, constant: 0)
        view.addConstraints([cell3CenterXConstraint, cell3TopConstraint, cell3HeightConstraint, cell3WidthConstraint])
        var cell3TopBorder = UIView(frame: CGRectMake(0, 0, cellWidth, 1))
        cell3TopBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        cell3.addSubview(cell3TopBorder)

        let cell4CenterXConstraint = NSLayoutConstraint(item: cell4, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let cell4TopConstraint = NSLayoutConstraint(item: cell4, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: cell4TopConstant)
        let cell4HeightConstraint = NSLayoutConstraint(item: cell4, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: cellHeightMultiplier, constant: 0)
        let cell4WidthConstraint = NSLayoutConstraint(item: cell4, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellWidthMultiplier, constant: 0)
        view.addConstraints([cell4CenterXConstraint, cell4TopConstraint, cell4HeightConstraint, cell4WidthConstraint])
        var cell4TopBorder = UIView(frame: CGRectMake(0, 0, cellWidth, 1))
        cell4TopBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        cell4.addSubview(cell4TopBorder)
        var cell4BottomBorder = UIView(frame: CGRectMake(0, cellHeight - 1, cellWidth, 1))
        cell4BottomBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        cell4.addSubview(cell4BottomBorder)

    }

    func initializeLabels() {

        let emailLabelTopConstant = CGFloat(0.1778169014*viewHeight)
        let emailLabelHeightMultiplier = CGFloat(0.04577464788)
        let emailLabelWidthMultiplier = CGFloat(0.9)
        
        let emailLabelCenterXConstraint = NSLayoutConstraint(item: emailLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let emailLabelTopConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: emailLabelTopConstant)
        let emailLabelHeightConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: emailLabelHeightMultiplier, constant: 0)
        let emailLabelWidthConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: emailLabelWidthMultiplier, constant: 0)
        view.addConstraints([emailLabelCenterXConstraint, emailLabelTopConstraint, emailLabelHeightConstraint, emailLabelWidthConstraint])

        let notificationLabelLeadingConstant = CGFloat(0.04375*viewWidth)
        let notificationLabelTopConstant = CGFloat(0.28345070422*viewHeight)
        let notificationLabelHeightMultiplier = CGFloat(0.03697183098)
        let notificationLabelWidthMultiplier = CGFloat(0.34375)
        
        let notificationLabelLeadingConstraint = NSLayoutConstraint(item: notificationLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: notificationLabelLeadingConstant)
        let notificationLabelTopConstraint = NSLayoutConstraint(item: notificationLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: notificationLabelTopConstant)
        let notificationLabelHeightConstraint = NSLayoutConstraint(item: notificationLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: notificationLabelHeightMultiplier, constant: 0)
        let notificationLabelWidthConstraint = NSLayoutConstraint(item: notificationLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: notificationLabelWidthMultiplier, constant: 0)
        view.addConstraints([notificationLabelLeadingConstraint, notificationLabelTopConstraint, notificationLabelHeightConstraint, notificationLabelWidthConstraint])

        let cellLabelLeadingConstant = CGFloat(0.021875*viewWidth)
        let cellLabelWidthMultiplier = CGFloat(0.34375)

        let startTimeLabelLeadingConstraint = NSLayoutConstraint(item: startTimeLabel, attribute: .Leading, relatedBy: .Equal, toItem: cell1, attribute: .Leading, multiplier: 1.0, constant: cellLabelLeadingConstant)
        let startTimeLabelCenterYConstraint = NSLayoutConstraint(item: startTimeLabel, attribute: .CenterY, relatedBy: .Equal, toItem: cell1, attribute: .CenterY, multiplier: 1.0, constant: 0)
        let startTimeLabelWidthConstraint = NSLayoutConstraint(item: startTimeLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellLabelWidthMultiplier, constant: 0)
        view.addConstraints([startTimeLabelLeadingConstraint, startTimeLabelCenterYConstraint, startTimeLabelWidthConstraint])

        let endTimeLabelLeadingConstraint = NSLayoutConstraint(item: endTimeLabel, attribute: .Leading, relatedBy: .Equal, toItem: cell2, attribute: .Leading, multiplier: 1.0, constant: cellLabelLeadingConstant)
        let endTimeLabelCenterYConstraint = NSLayoutConstraint(item: endTimeLabel, attribute: .CenterY, relatedBy: .Equal, toItem: cell2, attribute: .CenterY, multiplier: 1.0, constant: 0)
        let endTimeLabelWidthConstraint = NSLayoutConstraint(item: endTimeLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellLabelWidthMultiplier, constant: 0)
        view.addConstraints([endTimeLabelLeadingConstraint, endTimeLabelCenterYConstraint, endTimeLabelWidthConstraint])

        let frequencyLabelLeadingConstraint = NSLayoutConstraint(item: frequencyLabel, attribute: .Leading, relatedBy: .Equal, toItem: cell3, attribute: .Leading, multiplier: 1.0, constant: cellLabelLeadingConstant)
        let frequencyLabelCenterYConstraint = NSLayoutConstraint(item: frequencyLabel, attribute: .CenterY, relatedBy: .Equal, toItem: cell3, attribute: .CenterY, multiplier: 1.0, constant: 0)
        let frequencyLabelWidthConstraint = NSLayoutConstraint(item: frequencyLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellLabelWidthMultiplier, constant: 0)
        view.addConstraints([frequencyLabelLeadingConstraint, frequencyLabelCenterYConstraint, frequencyLabelWidthConstraint])

        let questionsLabelLeadingConstraint = NSLayoutConstraint(item: questionsLabel, attribute: .Leading, relatedBy: .Equal, toItem: cell4, attribute: .Leading, multiplier: 1.0, constant: cellLabelLeadingConstant)
        let questionsLabelCenterYConstraint = NSLayoutConstraint(item: questionsLabel, attribute: .CenterY, relatedBy: .Equal, toItem: cell4, attribute: .CenterY, multiplier: 1.0, constant: 0)
        let questionsLabelWidthConstraint = NSLayoutConstraint(item: questionsLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellLabelWidthMultiplier, constant: 0)
        view.addConstraints([questionsLabelLeadingConstraint, questionsLabelCenterYConstraint, questionsLabelWidthConstraint])

        emailLabel.text = userSettings["email"] as String
    }

    func initializeTextFields() {

        let cellTextFieldLeadingConstant = CGFloat(0.44375*viewWidth)
        let cellTextFieldWidthMultiplier = CGFloat(0.534375)

        startTimeTextField.borderStyle = .None
        let startTimeTextFieldLeadingConstraint = NSLayoutConstraint(item: startTimeTextField, attribute: .Leading, relatedBy: .Equal, toItem: cell1, attribute: .Leading, multiplier: 1.0, constant: cellTextFieldLeadingConstant)
        let startTimeTextFieldCenterYConstraint = NSLayoutConstraint(item: startTimeTextField, attribute: .CenterY, relatedBy: .Equal, toItem: cell1, attribute: .CenterY, multiplier: 1.0, constant: 0)
        let startTimeTextFieldWidthConstraint = NSLayoutConstraint(item: startTimeTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellTextFieldWidthMultiplier, constant: 0)
        view.addConstraints([startTimeTextFieldLeadingConstraint, startTimeTextFieldCenterYConstraint, startTimeTextFieldWidthConstraint])

        endTimeTextField.borderStyle = .None
        let endTimeTextFieldLeadingConstraint = NSLayoutConstraint(item: endTimeTextField, attribute: .Leading, relatedBy: .Equal, toItem: cell2, attribute: .Leading, multiplier: 1.0, constant: cellTextFieldLeadingConstant)
        let endTimeTextFieldCenterYConstraint = NSLayoutConstraint(item: endTimeTextField, attribute: .CenterY, relatedBy: .Equal, toItem: cell2, attribute: .CenterY, multiplier: 1.0, constant: 0)
        let endTimeTextFieldWidthConstraint = NSLayoutConstraint(item: endTimeTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellTextFieldWidthMultiplier, constant: 0)
        view.addConstraints([endTimeTextFieldLeadingConstraint, endTimeTextFieldCenterYConstraint, endTimeTextFieldWidthConstraint])

        frequencyTextField.borderStyle = .None
        let frequencyTextFieldLeadingConstraint = NSLayoutConstraint(item: frequencyTextField, attribute: .Leading, relatedBy: .Equal, toItem: cell3, attribute: .Leading, multiplier: 1.0, constant: cellTextFieldLeadingConstant)
        let frequencyTextFieldCenterYConstraint = NSLayoutConstraint(item: frequencyTextField, attribute: .CenterY, relatedBy: .Equal, toItem: cell3, attribute: .CenterY, multiplier: 1.0, constant: 0)
        let frequencyTextFieldWidthConstraint = NSLayoutConstraint(item: frequencyTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellTextFieldWidthMultiplier, constant: 0)
        view.addConstraints([frequencyTextFieldLeadingConstraint, frequencyTextFieldCenterYConstraint, frequencyTextFieldWidthConstraint])

        questionsTextField.borderStyle = .None
        let questionsTextFieldLeadingConstraint = NSLayoutConstraint(item: questionsTextField, attribute: .Leading, relatedBy: .Equal, toItem: cell4, attribute: .Leading, multiplier: 1.0, constant: cellTextFieldLeadingConstant)
        let questionsTextFieldCenterYConstraint = NSLayoutConstraint(item: questionsTextField, attribute: .CenterY, relatedBy: .Equal, toItem: cell4, attribute: .CenterY, multiplier: 1.0, constant: 0)
        let questionsTextFieldWidthConstraint = NSLayoutConstraint(item: questionsTextField, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cellTextFieldWidthMultiplier, constant: 0)
        view.addConstraints([questionsTextFieldLeadingConstraint, questionsTextFieldCenterYConstraint, questionsTextFieldWidthConstraint])

        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        let startTime = userSettings["notificationStartTime"] as NSDate
        let endTime = userSettings["notificationEndTime"] as NSDate

        startTimeTextField.text = dateFormatter.stringFromDate(startTime)
        currentStartTime = startTime
        endTimeTextField.text = dateFormatter.stringFromDate(endTime)
        currentEndTime = endTime

        let notificationFrequency = userSettings["notificationFrequency"] as Int
        let freq = String(notificationFrequency)
        frequencyTextField.text = freq

        let notificationQuestions = userSettings["questionsPerNotification"] as Int
        let questions = String(notificationQuestions)
        questionsTextField.text = questions

        //Attach datepicker to textFields
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Time
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.addTarget(self, action: "updateDate", forControlEvents: .ValueChanged)

        startTimeTextField.inputView = datePicker
        endTimeTextField.inputView = datePicker

    }

    func initializeButtons() {
        let logOutButtonTopConstant = CGFloat(0.80633802816*viewHeight)
        let buttonHeightMultiplier = CGFloat(0.07496251874)
        let buttonWidthMultiplier = CGFloat(0.608)

        logOutButton.layer.borderWidth = 1.0
        logOutButton.layer.borderColor = UIColor(red: 204.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
        logOutButton.layer.cornerRadius = 5
        let logOutButtonCenterXConstraint = NSLayoutConstraint(item: logOutButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let logOutButtonTopConstraint = NSLayoutConstraint(item: logOutButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: logOutButtonTopConstant)
        let logOutButtonHeightConstraint = NSLayoutConstraint(item: logOutButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let logOutButtonWidthConstraint = NSLayoutConstraint(item: logOutButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([logOutButtonCenterXConstraint, logOutButtonTopConstraint, logOutButtonHeightConstraint, logOutButtonWidthConstraint])
    }

    func updateDate() {

        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        if currentTextField == "StartTime" {
            startTimeTextField.text = dateFormatter.stringFromDate(datePicker.date)
            currentStartTime = datePicker.date
        }
        else if currentTextField == "EndTime" {
            endTimeTextField.text = dateFormatter.stringFromDate(datePicker.date)
            currentEndTime = datePicker.date
        }

    }

    func textFieldDidBeginEditing(textField: UITextField!) {
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.25)
        view.center = CGPointMake(self.originalCenter.x, keyboardPushedNewCenter);
        UIView.commitAnimations()

        if textField == startTimeTextField {
            currentTextField = "StartTime"
            datePicker.date = userSettings["notificationStartTime"] as NSDate
        }
        else if textField == endTimeTextField {
            currentTextField = "EndTime"
            datePicker.date = userSettings["notificationEndTime"] as NSDate
        }

    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.25)
        view.center = CGPointMake(self.originalCenter.x, self.originalCenter.y);
        UIView.commitAnimations()

        if textField == startTimeTextField {
            userSettings["notificationStartTime"] = currentStartTime
        }
        else if textField == endTimeTextField {
            userSettings["notificationEndTime"] = currentEndTime
        }
        else if textField == frequencyTextField {
            userSettings["notificationFrequency"] = frequencyTextField.text.toInt()
        }
        else if textField == questionsTextField {
            if questionsTextField.text.toInt() >= 10 {
                userSettings["questionsPerNotification"] = questionsTextField.text.toInt()
            }
        }

        if questionsTextField.text.toInt() < 10 {
            var alert = UIAlertController(title: "Error", message: "You must have a minimum of 10 questions per notification", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            userSettings.saveInBackground()
        }

    }

    @IBAction func logOutUser() {
        var alert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { action in
            NSLog("Logging out...")
            //log out facebook:
            FBSession.activeSession().closeAndClearTokenInformation()
            //log out:
            PFUser.logOut()
            self.view.endEditing(true)      
            //Prepare new view controller
            var loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            var newNavigationController = loginStoryboard.instantiateInitialViewController() as UINavigationController
            newNavigationController.modalTransitionStyle = .FlipHorizontal
            self.presentViewController(newNavigationController, animated: true, completion: nil)           
            self.navigationController?.popToRootViewControllerAnimated(true)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
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
