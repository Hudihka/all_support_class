//
//  InterfaceController.swift
//  WorkingPro WatchKit Extension
//
//  Created by Константин Ирошников on 30.08.2022.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func playAction() {
        guard let voiceMemo = VoiceMemo.generateVoice else {
            return
        }

//        presentMediaPlayerController(
//          with: voiceMemo.url,
//          options: nil,
//          completion: {_,_,_ in }
//        )

        presentController(
              withName: "AudioPlayerInterfaceController",
              context: voiceMemo
        )
    }

    @IBAction func writeSound() {
        addVoiceMemoMenuItemTapped()
    }
}

private extension InterfaceController {
    func addVoiceMemoMenuItemTapped() {

        let outputURL = MemoFileNameHelper.newOutputURL()

        let preset = WKAudioRecorderPreset.narrowBandSpeech

        // опция которая говорит что максимальная продолжительность записи 30 сек
        let options: [String : Any] = [WKAudioRecorderControllerOptionsMaximumDurationKey: 30]
        // 4
        presentAudioRecorderController(
          withOutputURL: outputURL,
          preset: preset,
          options: options) {
            [weak self] (didSave: Bool, error: Error?) in
        // 5
            guard didSave else { return }
//            self?.processRecordedAudio(at: outputURL)
        }
    }
}
