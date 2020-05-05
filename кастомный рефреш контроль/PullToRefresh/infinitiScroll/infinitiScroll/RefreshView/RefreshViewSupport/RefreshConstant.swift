//
//  RefreshConstant.swift
//  infinitiScroll
//
//  Created by Hudihka on 01/05/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

struct RefreshConstant {
	
	/* диаметр большого круга*/
	static let hBigView: CGFloat = 50
	
	/*если оттянуть на эту высоту то начнет появлятся большой круг*/
	static let startVisibleOffsetBig: CGFloat = 50
	
	/*дробное число говорящие во сколько мелкий круг меньше большого*/
	static let procentValueMinCircle: CGFloat = 0.5
	
	/*размер мелкого круга*/
	static var hSmallView: CGFloat {
		return procentValueMinCircle * hBigView
	}
	
	
	
	
	
	
	
	
	/*если оттянуть на эту высоту то начнет появлятся мелкий круг*/
	static var startVisibleOffsetSmall: CGFloat{
		let offset = (hBigView - hSmallView) / 2
		return startVisibleOffsetBig + offset
	}
	
	/*финальная высота вью рефреша*/
	static let finalHeightView: CGFloat = 100
}
