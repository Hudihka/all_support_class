//
//  InstagramFeedRequest.swift
//  ChefMarket_2.0
//
//  Created by Александр Нейфельд on 16.03.2018.
//  Copyright © 2018 itMegaStar. All rights reserved.
//

import UIKit

class InstagramFeedRequest: BaseRequest {
    let kInstaPath = "instagram-feed"

    override var urlString: String {
        return kBasePath + kInstaPath
    }
    
    override func handle(_ array: Array<Dictionary<String,Any>>) {
        onSuccess(array.map{InstogramFeedItem(dict: $0)}, nil)
    }
    
}
