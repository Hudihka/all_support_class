//
//  ViewController.swift
//  hyperLink
//
//  Created by Hudihka on 17/07/2020.
//  Copyright © 2020 OOO MegaStar. All rights reserved.
//

import UIKit
import ActiveLabel

class ViewController: UIViewController {

	@IBOutlet weak var labelOne: ActiveLabel!
	@IBOutlet weak var labelTwo: ActiveLabel!
	
	
	let textOne = "Тестовая гиперссылка со словом Подписки ка то так"
	let textTwo = "Тестовая гиперссылка со словом https://github.com/optonaut/ActiveLabel.swift как то так"
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let customType = ActiveType.custom(pattern: "\\sПодписки\\b") //Regex that looks for "Подписки"
		labelOne.enabledTypes = [.mention, .hashtag, .url, customType]
		labelOne.text = textOne
		labelOne.customColor[customType] = UIColor.purple
		labelOne.customSelectedColor[customType] = UIColor.green
			
		labelOne.handleCustomTap(for: customType) { element in
			print("Custom type tapped: \(element)")
		}
		
		
		
		let customType2 = ActiveType.custom(pattern: "\\shttps://github.com/optonaut/ActiveLabel.swift\\b") //Regex that looks for "with"
		labelTwo.enabledTypes = [customType2]
		labelTwo.text = textTwo
		labelTwo.customColor[customType2] = UIColor.purple
		labelTwo.customSelectedColor[customType2] = UIColor.green
			
		labelTwo.handleCustomTap(for: customType2) { element in
			print("Custom type tapped: \(element)")
		}
		
	}


}

