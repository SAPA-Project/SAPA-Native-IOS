//
//  SlideRightSegue.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/1/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import Foundation
import UIKit

@objc(SlideRightSegue)
class SlideRightSegue: UIStoryboardSegue {
    
    override func perform() {
        
        var sourceViewController = self.sourceViewController as UIViewController
        var destinationViewController = self.destinationViewController as UIViewController
        
        var transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        
        sourceViewController.view.window?.layer.addAnimation(transition, forKey: nil)
        
        sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
        
    }
    
}
