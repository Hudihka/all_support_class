//
//  DataManager.swift
//  PageImageVC
//
//  Created by Hudihka on 03/10/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

final class DataManager: NSObject {
	
	static var imageNameArray: [UIImage?] = []
	
	
	static func createArray(){
		
		for i in 0...49 {
			let name = "img_\(i)"
			let image = UIImage(named: name)
			imageNameArray.append(image)
		}
	}
	
	
}
