//
//  MenuViewController.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/8/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var userSettings: PFObject!

    var viewWidth: Double!
    var viewHeight: Double!
    
    @IBOutlet var profilePicture: UIImageView!

    @IBOutlet var emailLabel: UILabel!

    @IBOutlet var profileButton: UIButton!
    @IBOutlet var statsButton: UIButton!
    @IBOutlet var settingsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //Get screen size
        let screenRect = view.bounds
        let screenWidth = Double(screenRect.size.width)
        let screenHeight = Double(screenRect.size.height)
        viewWidth = screenWidth
        viewHeight = screenHeight
        
        //Initialize elements:
        initializeButtons()
        initializeImages()
        initializeLabels()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeButtons() {

        let profileButtonTopConstant = CGFloat(0.48239436619*viewHeight)
        let statsButtonTopConstant = CGFloat(0.58450704225*viewHeight)
        let settingsButtonTopConstant = CGFloat(0.68661971831*viewHeight)
        
        let buttonHeightMultiplier = CGFloat(0.11211267605)
        let buttonWidthMultiplier = CGFloat(0.690625)
        
        let buttonWidth = CGFloat(0.690625*viewWidth)
        let buttonHeight = CGFloat(0.11211267605*viewHeight)
        
        let profileButtonCenterXConstraint = NSLayoutConstraint(item: profileButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let profileButtonTopConstraint = NSLayoutConstraint(item: profileButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: profileButtonTopConstant)
        let profileButtonHeightConstraint = NSLayoutConstraint(item: profileButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let profileButtonWidthConstraint = NSLayoutConstraint(item: profileButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([profileButtonCenterXConstraint, profileButtonTopConstraint, profileButtonHeightConstraint, profileButtonWidthConstraint])
        var profileButtonTopBorder = UIView(frame: CGRectMake(0, 0, buttonWidth, 1))
        profileButtonTopBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        profileButton.addSubview(profileButtonTopBorder)
        
        let statsButtonCenterXConstraint = NSLayoutConstraint(item: statsButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let statsButtonTopConstraint = NSLayoutConstraint(item: statsButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: statsButtonTopConstant)
        let statsButtonHeightConstraint = NSLayoutConstraint(item: statsButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let statsButtonWidthConstraint = NSLayoutConstraint(item: statsButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([statsButtonCenterXConstraint, statsButtonTopConstraint, statsButtonHeightConstraint, statsButtonWidthConstraint])
        var statsButtonTopBorder = UIView(frame: CGRectMake(0, 0, buttonWidth, 1))
        statsButtonTopBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        statsButton.addSubview(statsButtonTopBorder)
        
        
        let settingsButtonCenterXConstraint = NSLayoutConstraint(item: settingsButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let settingsButtonTopConstraint = NSLayoutConstraint(item: settingsButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: settingsButtonTopConstant)
        let settingsButtonHeightConstraint = NSLayoutConstraint(item: settingsButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: buttonHeightMultiplier, constant: 0)
        let settingsButtonWidthConstraint = NSLayoutConstraint(item: settingsButton, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: buttonWidthMultiplier, constant: 0)
        view.addConstraints([settingsButtonCenterXConstraint, settingsButtonTopConstraint, settingsButtonHeightConstraint, settingsButtonWidthConstraint])
        var settingsButtonTopBorder = UIView(frame: CGRectMake(0, 0, buttonWidth, 1))
        settingsButtonTopBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        settingsButton.addSubview(settingsButtonTopBorder)
        var settingsButtonBottomBorder = UIView(frame: CGRectMake(0, buttonHeight - 1, buttonWidth, 1))
        settingsButtonBottomBorder.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        settingsButton.addSubview(settingsButtonBottomBorder)

    }

    func initializeImages() {
        let profilePictureTopConstant = CGFloat(0.08802816901*viewHeight)
        let profilePictureHeightMultiplier = CGFloat(0.21126760563)
        let profilePictureWidthMultiplier = CGFloat(0.375)
        
        let imageWidth = CGFloat(0.375*viewWidth)
        
        let profilePictureCenterXConstraint = NSLayoutConstraint(item: profilePicture, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let profilePictureTopConstraint = NSLayoutConstraint(item: profilePicture, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: profilePictureTopConstant)
        let profilePictureHeightConstraint = NSLayoutConstraint(item: profilePicture, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: profilePictureHeightMultiplier, constant: 0)
        let profilePictureWidthConstraint = NSLayoutConstraint(item: profilePicture, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: profilePictureWidthMultiplier, constant: 0)
        view.addConstraints([profilePictureCenterXConstraint, profilePictureTopConstraint, profilePictureHeightConstraint, profilePictureWidthConstraint])
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.borderWidth = 1.0
        profilePicture.layer.borderColor = UIColor.blackColor().CGColor
        profilePicture.layer.cornerRadius = imageWidth/2
    }

    func initializeLabels() {
        let emailLabelTopConstant = CGFloat(0.36619718309*viewHeight)
        let emailLabelHeightMultiplier = CGFloat(0.03697183098)
        let emailLabelWidthMultiplier = CGFloat(0.9)
        
        let emailLabelCenterXConstraint = NSLayoutConstraint(item: emailLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let emailLabelTopConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: emailLabelTopConstant)
        let emailLabelHeightConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: emailLabelHeightMultiplier, constant: 0)
        let emailLabelWidthConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: emailLabelWidthMultiplier, constant: 0)
        view.addConstraints([emailLabelCenterXConstraint, emailLabelTopConstraint, emailLabelHeightConstraint, emailLabelWidthConstraint])

        var userEmail = userSettings["email"] as String
        emailLabel.text = userEmail
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
