//
//  RecieptViewControllerProtocols.swift
//  FooDoo.ai
//
//  Created by Hudihka on 12/01/2022.
//  Copyright © 2022 ITMegastar. All rights reserved.
//

import Foundation

protocol RecieptViewControllerProtocolIn {
    func fetchData()

    func next(html: Any?)
}

protocol RecieptViewControllerProtocolOut {
    var content: (URL?) -> Void { get set }
}
