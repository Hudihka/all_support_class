//
//  EnumAngels.swift
//  infinitiScroll
//
//  Created by Hudihka on 01/05/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

	private let minPi: Double = Double.pi * 0.075


enum EnumAngels: Double{
	case zero
	case threeHours
	case sixHours
	case nineHours
	
	private var startValue: Double{
		switch self {
		case .zero:
			return -.pi/2
		case .threeHours:
			return 0
		case .sixHours:
			return .pi/2
		case .nineHours:
			return .pi
		}
	}
	
	private var minPi: Double {
		return Double.pi * 0.075
	}
	
	//если да, то не доходя до знвчения
	func finishValue(from: Bool) -> Double{
		let value = from ? -1 * minPi : minPi
		return self.startValue + value
	}
	
	
	
}
