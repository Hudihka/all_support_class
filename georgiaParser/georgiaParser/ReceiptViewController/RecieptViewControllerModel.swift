//
//  RecieptViewControllerModel.swift
//  FooDoo.ai
//
//  Created by Hudihka on 12/01/2022.
//  Copyright © 2022 ITMegastar. All rights reserved.
//

import Foundation

final class RecieptViewControllerModel: RecieptViewControllerProtocolIn,
                                        RecieptViewControllerProtocolOut {
    private let url: URL?

    var content: (URL?) -> Void = { _ in }

    init(url: String) {
        self.url = URL(string: url)
    }

    func fetchData() {
        content(url)
    }
}
