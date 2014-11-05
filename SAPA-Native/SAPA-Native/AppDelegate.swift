//
//  AppDelegate.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/1/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        //Initialize Parse
        Parse.setApplicationId("8WtfuZE2iww0adKIOU3x3DJH3LZK13zN6cAMQrtY", clientKey: "MzY50mxqRjmqm5uWm0eBOnTshAi9NumMZ7EU31mL")

        //Register for Push notifications:
        let notificationTypes:UIUserNotificationType = .Alert | .Badge | .Sound
        let notificationSettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)

        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)

        //Facebook:
        FBLoginView.self
        FBProfilePictureView.self
        // Whenever a person opens the app, check for a cached session
        if FBSession.activeSession().state == FBSessionState.CreatedTokenLoaded {
        // If there's one, just open the session silently, without showing the user the login UI
            var permissions = ["public_profile"]
            FBSession.openActiveSessionWithReadPermissions(permissions, allowLoginUI: false, completionHandler: {
                (session: FBSession!, state: FBSessionState!, error: NSError!) -> Void in

                // Retrieve the app delegate
                var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
                appDelegate.sessionStateChanged(session, state: state, error: error)

            })
        }

        return true
    }

    //Facebook:
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: NSString?, annotation: AnyObject) -> Bool {
        var wasHandled:Bool = FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
        return wasHandled
    }
    
    func application(application: UIApplication!, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings!) {
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication!, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!) {
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if success != nil {
                NSLog("Success!")
            }
            else {
                let errorString = error.userInfo!["error"] as NSString
                NSLog("%@", errorString)
            }
        }
    }
    
    func application(application: UIApplication!, didFailToRegisterForRemoteNotificationsWithError error: NSError!) {
        println(error.localizedDescription)
    }
    
    func application(application: UIApplication!, didReceiveRemoteNotification userInfo:NSDictionary!) {
        
        var notification:NSDictionary = userInfo.objectForKey("aps") as NSDictionary
        
        if notification.objectForKey("content-available") != nil {
            if notification.objectForKey("content-available")!.isEqualToNumber(1){
                NSNotificationCenter.defaultCenter().postNotificationName("reloadTimeline", object: nil)
            }
        }
        else {
            PFPush.handlePush(userInfo)
        }
        
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            let currentNavigationController = self.window!.rootViewController as UINavigationController
            currentNavigationController.popToRootViewControllerAnimated(false)
            let currentViewController = currentNavigationController.visibleViewController
            if currentViewController.isKindOfClass(MenuViewController) {
                let menuViewController = currentViewController as MenuViewController
                menuViewController.validateFacebookSession()
                menuViewController.checkForAlert()
            }
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sapa-project.SAPA_Native" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("SAPA_Native", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SAPA_Native.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

    // Facebook session handler

    func sessionStateChanged(session: FBSession, state: FBSessionState, error: NSError!) {
          // If the session was opened successfully
        if error == nil && state == FBSessionState.Open {
            NSLog("Session opened");
            // Show the user the logged-in UI
//            self.userLoggedIn()
            return
        }
        if state == FBSessionState.Closed || state == FBSessionState.ClosedLoginFailed {
            // If the session is closed
            NSLog("Session closed");
            // Show the user the logged-out UI
//            self.userLoggedOut()
        }

          // Handle errors
        if error != nil {
            NSLog("Error");
            var alertText = NSString()
            var alertTitle = NSString()
            // If the error requires people using an app to make an action outside of the app in order to recover
            if FBErrorUtility.shouldNotifyUserForError(error) == true {
                alertTitle = "Something went wrong"
                NSLog("%@", FBErrorUtility.userMessageForError(error))
//                self.showMessage(alertText, withTitle: alertTitle)
            }
            else {

                // If the user cancelled login, do nothing
                if FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.UserCancelled {
                    NSLog("User cancelled login")
                }
                else if FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.AuthenticationReopenSession {
                    alertTitle = "Session Error"
                    NSLog("Your current session is no longer valid. Please log in again.")
//                    self.showMessage(alertText, withTitle: alertTitle)
                }
                else {
//                    var errorInformation = NSDictionary(error.userInfo).objectForKey("com.facebook.sdk:ParsedJSONResponseKey").objectForKey("body").objectForKey("error") as NSDictionary
                    // Show the user an error message
                    NSLog("Something went wrong")
//                    alertText = NSString.stringWithFormat("Please retry. \n\n If the problem persists contact us and mention this error code: %@", errorInformation.objectForKey("message"))
//                    self.showMessage(alertText, withTitle: alertTitle)
                }

            }
            // Clear this token
            FBSession.activeSession().closeAndClearTokenInformation()
//            self.userLoggedOut()
        }
    }



}

