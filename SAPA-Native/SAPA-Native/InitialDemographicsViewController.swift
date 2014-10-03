//
//  InitialDemographicsViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/2/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class InitialDemographicsViewController: UIViewController {
    
    var viewWidth: Double!
    var viewHeight: Double!
    
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var getStartedButton: UIButton!
//    @IBOutlet var picker: UIPickerView!
//    
//    var genderPickerData: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initializeButtons()
        initializeTextFields()
        
        let screenRect = view.bounds
        let screenWidth = Double(screenRect.size.width)
        let screenHeight = Double(screenRect.size.height)
        viewWidth = screenWidth
        viewHeight = screenHeight
        NSLog("width and height:")
        NSLog("%f", screenWidth)
        NSLog("%f", screenHeight)
        
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
        getStartedButton.layer.borderWidth = 1.0
        getStartedButton.layer.borderColor = UIColor(red: 64.0/255.0, green: 115.0/255.0, blue: 180.0/255.0, alpha: 1.0).CGColor
        getStartedButton.layer.cornerRadius = 5
    }
    
    func initializeTextFields() {
        
        ageTextField.layer.borderWidth = 1.0
        ageTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        ageTextField.layer.cornerRadius = 5
        var ageTextFieldHeightConstraint = NSLayoutConstraint(item: ageTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 0.0, constant: 50.0)
        view.addConstraint(ageTextFieldHeightConstraint)
        
        
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
