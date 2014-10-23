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