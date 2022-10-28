//
//  StartViewModel.swift
//  MVVM
//
//  Created by Hudihka on 02/05/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation

protocol StartInputProtocol {
	func sliderValue(value: Float)
	func steperValue(value: Double)
	func switchValue(value: Bool)
}

protocol StartOutputProtocol {
	var sliderText: String {get set}
	var steperText: String {get set}
	var switchText: String {get set}
}

class StartViewPresenter: StartInputProtocol, StartOutputProtocol{
	
	var sliderText: String
	var steperText: String
	var switchText: String
	
	init() {
		self.sliderText = "0.5"
		self.steperText = "0"
		self.switchText = "yes"
	}
	
	func sliderValue(value: Float) {
		sliderText = "\(value)"
	}
	
	func steperValue(value: Double) {
		steperText = "\(value)"
	}
	
	func switchValue(value: Bool) {
		switchText = value ? "yes" : "no"
	}
	
	
	
	
	
	
}
