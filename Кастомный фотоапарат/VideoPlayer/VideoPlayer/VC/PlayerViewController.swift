//
//  PlayerViewController.swift
//  VideoPlayer
//
//  Created by Админ on 24.09.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {
   private var videoContent: AVPlayerItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo()
    }

    static func route(_ videoContent: AVPlayerItem?) -> PlayerViewController {
        let VC = EnumStoryboard.main.vc("PlayerViewController") as! PlayerViewController
        VC.videoContent = videoContent
        VC.modalPresentationStyle = .fullScreen

        return VC
    }

    private func playVideo() {
        if let content = self.videoContent {
            let player = AVPlayer(playerItem: content)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            self.player = player
            player.play()
        }
    }
}
