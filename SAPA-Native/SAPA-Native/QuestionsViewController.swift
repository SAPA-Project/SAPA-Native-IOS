//
//  QuestionsViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/15/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    var userSettings: PFObject!

    var viewWidth: Double!
    var viewHeight: Double!

    @IBOutlet var questionNumberLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var minLabel: UILabel!
    @IBOutlet var maxLabel: UILabel!

    @IBOutlet var slider: UISlider!

    @IBOutlet var nextButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var quitButton: UIButton!

    var questionArray: Array<Int>!

    var currentQuestionIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //Get screen size
        let screenRect = view.bounds
        let screenWidth = Double(screenRect.size.width)
        let screenHeight = Double(screenRect.size.height)
        viewWidth = screenWidth
        viewHeight = screenHeight

        questionArray = shuffle(STATEQUESTIONNUMBERS)
        currentQuestionIndex = 0

        //Initialize elements
        initializeLabels()
        initializeSlider()
        initializeButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeLabels() {

        var numQuestions = userSettings["questionsPerNotification"] as Int
        
        let questionNumberLabelTopConstant = CGFloat(0.07042253521*viewHeight)
        let questionNumberLabelHeightMultiplier = CGFloat(0.03697183098)
        let questionNumberLabelWidthMultiplier = CGFloat(0.825)
        
        let questionNumberLabelCenterXConstraint = NSLayoutConstraint(item: questionNumberLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let questionNumberLabelTopConstraint = NSLayoutConstraint(item: questionNumberLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: questionNumberLabelTopConstant)
        let questionNumberLabelHeightConstraint = NSLayoutConstraint(item: questionNumberLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: questionNumberLabelHeightMultiplier, constant: 0)
        let questionNumberLabelWidthConstraint = NSLayoutConstraint(item: questionNumberLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: questionNumberLabelWidthMultiplier, constant: 0)
        view.addConstraints([questionNumberLabelCenterXConstraint, questionNumberLabelTopConstraint, questionNumberLabelHeightConstraint, questionNumberLabelWidthConstraint])

        questionNumberLabel.text = "Question " + String(currentQuestionIndex + 1) + " of " + String(numQuestions)
    
        let questionLabelTopConstant = CGFloat(0.15316901408*viewHeight)
        let questionLabelHeightMultiplier = CGFloat(0.14084507042)
        let questionLabelWidthMultiplier = CGFloat(0.9375)
        
        let questionLabelCenterXConstraint = NSLayoutConstraint(item: questionLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let questionLabelTopConstraint = NSLayoutConstraint(item: questionLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: questionLabelTopConstant)
        let questionLabelHeightConstraint = NSLayoutConstraint(item: questionLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: questionLabelHeightMultiplier, constant: 0)
        let questionLabelWidthConstraint = NSLayoutConstraint(item: questionLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: questionLabelWidthMultiplier, constant: 0)
        view.addConstraints([questionLabelCenterXConstraint, questionLabelTopConstraint, questionLabelHeightConstraint, questionLabelWidthConstraint])
        questionLabel.numberOfLines = 3

        questionLabel.text = STATEQUESTIONS[questionArray[currentQuestionIndex]]! as String

        let minLabelLeadingConstant = CGFloat(0.0)
        let minLabelTopConstant = CGFloat(0.40669014084*viewHeight)
        let minLabelHeightMultiplier = CGFloat(0.08450704225)
        let minLabelWidthMultiplier = CGFloat(0.2375)
        
        let minLabelLeadingConstraint = NSLayoutConstraint(item: minLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: minLabelLeadingConstant)
        let minLabelTopConstraint = NSLayoutConstraint(item: minLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: minLabelTopConstant)
        let minLabelHeightConstraint = NSLayoutConstraint(item: minLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: minLabelHeightMultiplier, constant: 0)
        let minLabelWidthConstraint = NSLayoutConstraint(item: minLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: minLabelWidthMultiplier, constant: 0)
        view.addConstraints([minLabelLeadingConstraint, minLabelTopConstraint, minLabelHeightConstraint, minLabelWidthConstraint])
        minLabel.font = UIFont.systemFontOfSize(12.0)
        minLabel.numberOfLines = 2

        minLabel.text = "Not at all"

        let maxLabelLeadingConstant = CGFloat(0.7625*viewWidth)
        let maxLabelTopConstant = CGFloat(0.40669014084*viewHeight)
        let maxLabelHeightMultiplier = CGFloat(0.08450704225)
        let maxLabelWidthMultiplier = CGFloat(0.2375)
        
        let maxLabelLeadingConstraint = NSLayoutConstraint(item: maxLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: maxLabelLeadingConstant)
        let maxLabelTopConstraint = NSLayoutConstraint(item: maxLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: maxLabelTopConstant)
        let maxLabelHeightConstraint = NSLayoutConstraint(item: maxLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: maxLabelHeightMultiplier, constant: 0)
        let maxLabelWidthConstraint = NSLayoutConstraint(item: maxLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: maxLabelWidthMultiplier, constant: 0)
        view.addConstraints([maxLabelLeadingConstraint, maxLabelTopConstraint, maxLabelHeightConstraint, maxLabelWidthConstraint])
        maxLabel.font = UIFont.systemFontOfSize(12.0)
        maxLabel.numberOfLines = 2

        maxLabel.text = "Very"

    }

    func initializeSlider() {
        let sliderTopConstant = CGFloat(0.35211267605*viewHeight)
        let sliderHeightMultiplier = CGFloat(0.05457746478)
        let sliderWidthMultiplier = CGFloat(0.7375)
        
        let sliderCenterXConstraint = NSLayoutConstraint(item: slider, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let sliderTopConstraint = NSLayoutConstraint(item: slider, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: sliderTopConstant)
        let sliderHeightConstraint = NSLayoutConstraint(item: slider, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: sliderHeightMultiplier, constant: 0)
        let sliderWidthConstraint = NSLayoutConstraint(item: slider, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: sliderWidthMultiplier, constant: 0)
        view.addConstraints([sliderCenterXConstraint, sliderTopConstraint, sliderHeightConstraint, sliderWidthConstraint])
        slider.setValue(0.5, animated: true)

        slider.addTarget(self, action: "enableNextButton", forControlEvents: .TouchDown)

    }

    func initializeButtons() {
        let enabledColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        let disabledColor = UIColor.lightGrayColor()
        
        let nextButtonTopConstant = CGFloat(0.57922535211*viewHeight)
        let buttonHeightMultiplier = CGFloat(0.08802816901)
        let buttonWidthMultiplier = CGFloat(0.608)
        
        nextButton.layer.borderWidth = 1.0
        nextButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        nextButton.setTitleColor(disabledColor, forState: .Disabled)
        nextButton.setTitleColor(enabledColor, forState: .Normal)
        nextButton.layer.cornerRadius = 5
        let nextButtonCenterXConstraint = NSLayoutConstraint(item: nextButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let nextButtonTopConstraint = NSLayoutConstraint(item: nextButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: nextButtonTopConstant)
        let nextButtonHeightConstraint = NSLayoutConstraint(item: nextButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let nextButtonWidthConstraint = NSLayoutConstraint(item: nextButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([nextButtonCenterXConstraint, nextButtonTopConstraint, nextButtonHeightConstraint, nextButtonWidthConstraint])
        nextButton.enabled = false

        let quitButtonLeadingConstant = CGFloat(0.41875*viewWidth)
        let quitButtonTopConstant = CGFloat(0.90845070422*viewHeight)
        let quitButtonHeightMultiplier = CGFloat(0.0528169014)
        let quitButtonWidthMultiplier = CGFloat(0.103125)
        
        let quitButtonLeadingConstraint = NSLayoutConstraint(item: quitButton, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: quitButtonLeadingConstant)
        let quitButtonTopConstraint = NSLayoutConstraint(item: quitButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: quitButtonTopConstant)
        let quitButtonHeightConstraint = NSLayoutConstraint(item: quitButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: quitButtonHeightMultiplier, constant: 0)
        let quitButtonWidthConstraint = NSLayoutConstraint(item: quitButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: quitButtonWidthMultiplier, constant: 0)
        view.addConstraints([quitButtonLeadingConstraint, quitButtonTopConstraint, quitButtonHeightConstraint, quitButtonWidthConstraint])

        let cancelButtonLeadingConstant = CGFloat(0.546875*viewWidth)
        let cancelButtonTopConstant = CGFloat(0.92429577464*viewHeight)
        let cancelButtonHeightMultiplier = CGFloat(0.02112676056)
        let cancelButtonWidthMultiplier = CGFloat(0.0375)
        
        let cancelButtonLeadingConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: cancelButtonLeadingConstant)
        let cancelButtonTopConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: cancelButtonTopConstant)
        let cancelButtonHeightConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: cancelButtonHeightMultiplier, constant: 0)
        let cancelButtonWidthConstraint = NSLayoutConstraint(item: cancelButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: cancelButtonWidthMultiplier, constant: 0)
        view.addConstraints([cancelButtonLeadingConstraint, cancelButtonTopConstraint, cancelButtonHeightConstraint, cancelButtonWidthConstraint])
    }
    
    func disableNextButton() {
        nextButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        nextButton.enabled = false
    }

    func enableNextButton() {
        nextButton.layer.borderColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0).CGColor
        nextButton.enabled = true
    }
    
    @IBAction func didTapNext() {

        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        var timeZone = currentInstallation["timeZone"] as String
        
        var numQuestions = userSettings["questionsPerNotification"] as Int
        
        var currentUserEmail = userSettings["email"] as String
        var questionText = STATEQUESTIONS[questionArray[currentQuestionIndex]]! as String
        var sliderValue = slider.value
        
        var questionType = "State"
        
        var userResponse = PFObject(className: "UserResponse")
        userResponse["email"] = currentUserEmail
        userResponse["questionText"] = questionText
        userResponse["responseValue"] = sliderValue
        userResponse["questionType"] = questionType
        userResponse["timeZone"] = timeZone
        userResponse["responseId"] = self.userSettings["responseId"]
        userResponse["itemId"] = questionArray[currentQuestionIndex] as Int
        userResponse.saveInBackground()
        
        if currentQuestionIndex == (numQuestions - 1) {
            self.userSettings.incrementKey("responseId");
            self.userSettings.saveInBackground();
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            
            slider.setValue(0.5, animated: true)
            
            disableNextButton()
            
            currentQuestionIndex = currentQuestionIndex + 1
            
            if currentQuestionIndex == (numQuestions - 1) {
                nextButton.setTitle("Done", forState: .Normal)
            }
            
            UIView.beginAnimations("animateText", context: nil)
            UIView.setAnimationCurve(.EaseIn)
            UIView.setAnimationDuration(0.5)
            questionNumberLabel.alpha = 0.0
            questionNumberLabel.text = "Question " + String(currentQuestionIndex + 1) + " of " + String(numQuestions)
            questionNumberLabel.alpha = 1.0
            UIView.commitAnimations()
            
            UIView.beginAnimations("animateText", context: nil)
            UIView.setAnimationCurve(.EaseIn)
            UIView.setAnimationDuration(0.5)
            questionLabel.alpha = 0.0
            questionLabel.text = STATEQUESTIONS[questionArray[currentQuestionIndex]]! as String
            questionLabel.alpha = 1.0
            UIView.commitAnimations()
        }
        
    }

    @IBAction func quit() {
        self.userSettings.incrementKey("responseId");
        self.userSettings.saveInBackground();
        self.dismissViewControllerAnimated(true, completion: nil)
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
