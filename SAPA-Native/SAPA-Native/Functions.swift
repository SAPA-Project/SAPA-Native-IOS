//
//  Functions.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/14/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import Foundation

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "h:mm a"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
}

func shuffle<T>(var list: Array<T>) -> Array<T> {
    for i in 0..<(list.count - 1) {
        let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
        swap(&list[i], &list[j])
    }
    return list
}

func squareImageFromImage(image: UIImage, newSize: CGFloat) -> UIImage {
    
    var scaleTransform: CGAffineTransform
    var origin: CGPoint

    if (image.size.width > image.size.height) {
        var scaleRatio = CGFloat(newSize / image.size.height)
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio)
		origin = CGPointMake(-(image.size.width - image.size.height) / 2.0, 0)
    } 
    else {
        var scaleRatio = CGFloat(newSize / image.size.width)
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio)
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0)
    }

    var size = CGSizeMake(newSize, newSize)
    if UIScreen.mainScreen().respondsToSelector("scale") {
    	UIGraphicsBeginImageContextWithOptions(size, true, 0)	
    }
    else {
    	UIGraphicsBeginImageContext(size)
    }
    // if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
    //     UIGraphicsBeginImageContextWithOptions(size, true, 0);
    // } else {
    //     UIGraphicsBeginImageContext(size);
    // }

    var context = UIGraphicsGetCurrentContext() as CGContextRef
    CGContextConcatCTM(context, scaleTransform)

    image.drawAtPoint(origin)

    var newImage = UIGraphicsGetImageFromCurrentImageContext()

    UIGraphicsEndImageContext()

    return newImage;

}