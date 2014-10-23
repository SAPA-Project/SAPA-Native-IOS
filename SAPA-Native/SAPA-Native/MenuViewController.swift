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

    @IBOutlet var profileIcon: UIImageView!
    @IBOutlet var statsIcon: UIImageView!
    @IBOutlet var settingsIcon: UIImageView!

    var loadMask: UIView!
    var activityIndicator: UIActivityIndicatorView!
    
    var viewLoadedAfterLogin: Bool!

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
        initializeIcons()
        initializeActivityIndicator()
        
        NSLog("loading view")
        
        if viewLoadedAfterLogin != nil {
            checkForAlert()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeButtons() {

        let profileButtonTopConstant = CGFloat(0.48239436619*viewHeight)
        let statsButtonTopConstant = CGFloat(0.58450704225*viewHeight)
        let settingsButtonTopConstant = CGFloat(0.68661971831*viewHeight)
        
        let buttonHeightMultiplier = CGFloat(0.10211267605)
        let buttonWidthMultiplier = CGFloat(0.690625)
        
        let buttonWidth = CGFloat(0.690625*viewWidth)
        let buttonHeight = CGFloat(0.10211267605*viewHeight)
        
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
        let emailLabelHeightMultiplier = CGFloat(0.04697183098)
        let emailLabelWidthMultiplier = CGFloat(0.9)
        
        let emailLabelCenterXConstraint = NSLayoutConstraint(item: emailLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let emailLabelTopConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: emailLabelTopConstant)
        let emailLabelHeightConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: emailLabelHeightMultiplier, constant: 0)
        let emailLabelWidthConstraint = NSLayoutConstraint(item: emailLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: emailLabelWidthMultiplier, constant: 0)
        view.addConstraints([emailLabelCenterXConstraint, emailLabelTopConstraint, emailLabelHeightConstraint, emailLabelWidthConstraint])

        var userEmail = userSettings["email"] as String
        emailLabel.text = userEmail
    }

    func initializeIcons() {

        let profileIconLeadingConstant = CGFloat(0.20625*viewWidth)
        let profileIconTopConstant = CGFloat(0.51408450704*viewHeight)
        let profileIconHeightMultiplier = CGFloat(0.03697183098)
        let profileIconWidthMultiplier = CGFloat(0.046875)
        
        let profileIconLeadingConstraint = NSLayoutConstraint(item: profileIcon, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: profileIconLeadingConstant)
        let profileIconTopConstraint = NSLayoutConstraint(item: profileIcon, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: profileIconTopConstant)
        let profileIconHeightConstraint = NSLayoutConstraint(item: profileIcon, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: profileIconHeightMultiplier, constant: 0)
        let profileIconWidthConstraint = NSLayoutConstraint(item: profileIcon, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: profileIconWidthMultiplier, constant: 0)
        view.addConstraints([profileIconLeadingConstraint, profileIconTopConstraint, profileIconHeightConstraint, profileIconWidthConstraint])

        let statsIconLeadingConstant = CGFloat(0.18125*viewWidth)
        let statsIconTopConstant = CGFloat(0.60739436619*viewHeight)
        let statsIconHeightMultiplier = CGFloat(0.05633802816)
        let statsIconWidthMultiplier = CGFloat(0.1)
        
        let statsIconLeadingConstraint = NSLayoutConstraint(item: statsIcon, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: statsIconLeadingConstant)
        let statsIconTopConstraint = NSLayoutConstraint(item: statsIcon, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: statsIconTopConstant)
        let statsIconHeightConstraint = NSLayoutConstraint(item: statsIcon, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: statsIconHeightMultiplier, constant: 0)
        let statsIconWidthConstraint = NSLayoutConstraint(item: statsIcon, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: statsIconWidthMultiplier, constant: 0)
        view.addConstraints([statsIconLeadingConstraint, statsIconTopConstraint, statsIconHeightConstraint, statsIconWidthConstraint])

        let settingsIconLeadingConstant = CGFloat(0.19375*viewWidth)
        let settingsIconTopConstant = CGFloat(0.71478873239*viewHeight)
        let settingsIconHeightMultiplier = CGFloat(0.0440140845)
        let settingsIconWidthMultiplier = CGFloat(0.078125)
        
        let settingsIconLeadingConstraint = NSLayoutConstraint(item: settingsIcon, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: settingsIconLeadingConstant)
        let settingsIconTopConstraint = NSLayoutConstraint(item: settingsIcon, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: settingsIconTopConstant)
        let settingsIconHeightConstraint = NSLayoutConstraint(item: settingsIcon, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: settingsIconHeightMultiplier, constant: 0)
        let settingsIconWidthConstraint = NSLayoutConstraint(item: settingsIcon, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: settingsIconWidthMultiplier, constant: 0)
        view.addConstraints([settingsIconLeadingConstraint, settingsIconTopConstraint, settingsIconHeightConstraint, settingsIconWidthConstraint])

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func checkForAlert() {

        loadMask.hidden = false
        activityIndicator.startAnimating()

        userSettings.fetchInBackgroundWithBlock {

            (userSettings: AnyObject!, error: NSError!) -> Void in

            self.loadMask.hidden = true
            self.activityIndicator.stopAnimating()

            if error == nil {
                self.userSettings = userSettings as PFObject
                var push = userSettings["push"] as Bool
                if push {
                    self.userSettings["push"] = false
                    self.userSettings.saveInBackground()
                    self.showQuestionsView()
                }
            }

            else {
                let errorString = error.userInfo!["error"] as NSString
            }

        }
    }

    func showQuestionsView() {
        let questionsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("QuestionsViewController") as QuestionsViewController
        questionsViewController.userSettings = userSettings
        questionsViewController.modalPresentationStyle = .Popover
        self.presentViewController(questionsViewController, animated: true, completion: nil)
    }

    @IBAction func showProfileView() {
        let profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
        profileViewController.userSettings = userSettings
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }

    @IBAction func showSettingsView() {
        let settingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as SettingsViewController
        settingsViewController.userSettings = userSettings
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }

}
