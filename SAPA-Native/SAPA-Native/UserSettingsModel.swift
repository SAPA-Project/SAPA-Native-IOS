//
//  UserSettingsModel.swift
//  SAPA-Native
//
//  Created by Brian Lai on 10/8/14.
//  Copyright (c) 2014 SAPA. All rights reserved.
//

import Foundation

class UserSettings {

	var currentUserSettings: PFObject!

	init(userSettings:PFObject) {
		self.currentUserSettings = userSettings
	}

	func getCurrentUserSettings() -> PFObject {
		return self.currentUserSettings
	}

	func setCurrentUserSettings(userSettings:PFObject) {
		self.currentUserSettings = userSettings
	}

}