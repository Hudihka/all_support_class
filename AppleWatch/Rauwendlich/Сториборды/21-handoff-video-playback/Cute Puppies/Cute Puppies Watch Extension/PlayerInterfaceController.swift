//
//  PlayerInterfaceController.swift
//  Cute Puppies Watch Extension
//
//  Created by Константин Ирошников on 04.09.2022.
//  Copyright © 2022 Soheil Azarpour. All rights reserved.
//

import Foundation
import WatchKit

class PlayerInterfaceController: WKInterfaceController {
    @IBOutlet var inlineMovie: WKInterfaceInlineMovie!
    @IBOutlet var textLabel: WKInterfaceLabel!

    private var clipIndex: Int?
    private var isPlaying: Bool = true

    override func awake(withContext context: Any?) {
      super.awake(withContext: context)
      // 1
      let index = context as! Int
    // 2
      let provider = VideoClipProvider()
      let clipURL = provider.clips[index]
      let quote = provider.quotes[index]
      // 3
      clipIndex = index
      inlineMovie.setMovieURL(clipURL)
      textLabel.setText(quote)
      setTitle(clipURL.lastPathComponent)
      // 4
      if let data =
        PosterImageProvider().imageDataForClip(withURL: clipURL) {
        let image = WKImage(imageData: data)
        inlineMovie.setPosterImage(image)
      }
    }

    override func willActivate() {
      super.willActivate()
      guard let clipIndex = clipIndex else { return }

      let userInfo: [AnyHashable: Any] = [
        Handoff.activityValueKey: clipIndex
      ]
        let activity = NSUserActivity(activityType: Handoff.Activity.playClip.stringValue)
        activity.userInfo = userInfo
        update(activity)
    }

    @IBAction func tapGesture(_ sender: Any) {
        if isPlaying {
          inlineMovie.pause()
          isPlaying = false
        } else {
          inlineMovie.play()
          isPlaying = true
        }
    }
}
