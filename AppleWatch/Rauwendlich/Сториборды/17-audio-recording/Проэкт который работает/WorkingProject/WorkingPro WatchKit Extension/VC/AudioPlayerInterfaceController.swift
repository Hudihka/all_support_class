//
//  AudioPlayerInterfaceController.swift
//  WorkingPro WatchKit Extension
//
//  Created by Константин Ирошников on 30.08.2022.
//

import Foundation
import WatchKit
import AVFoundation

final class AudioPlayerInterfaceController: WKInterfaceController {
    @IBOutlet private var playButton: WKInterfaceButton!
    @IBOutlet private var interfaceTimer: WKInterfaceTimer!
    @IBOutlet private var titleLabel: WKInterfaceLabel!

    private var player: AVAudioPlayer?
    private let session: AVAudioSession = .sharedInstance()
    private var memo: VoiceMemo!

    func prepareSession() {
        do {
            try session.setCategory(
                AVAudioSession.Category.playback,
                mode: .default,
                policy: .longFormAudio,
                options: []
            )
        }
        catch {
            print(error)
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        memo = context as? VoiceMemo
        prepareSession()
        titleLabel.setText(memo.filename)

        //        playButton.setEnabled(false)
    }

    @IBAction func playButtonTapped() {
        play(url: memo.url)// это воспроизведение в бэкграунде
//        player.play()
//
//        let duration = TimeInterval(CMTimeGetSeconds(player.currentTime()))
//        let date = Date(timeIntervalSinceNow:
//                            TimeInterval(
//                                CMTimeGetSeconds(player.currentTime())
//                            )
//        )
//        interfaceTimer.setDate(date)
//        interfaceTimer.start()
//
//
//
//        playButton.setEnabled(false)
//
//
//        let _ = Timer.scheduledTimer(
//           withTimeInterval: duration,
//           repeats: false, block: { _ in
//               self.playButton.setEnabled(true)
//           })
    }

    private func play(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
        }
        catch {
            print(error)
            return
        }

        session.activate(options: []) { (success, error) in
            guard error == nil else {
                print(error!)
                return
            }

            // Play the audio file
            self.player?.play()
        }
    }



//    не работает
    
    /*
    // игрокявляется примеромWKAudioFilePlayer. Вы будете использовать его для воспроизведения аудиофайла.
    private var player: WKAudioFilePlayer!
    // представляет собой голосовую заметку. Вы будете использовать
    //  это для создания нового WKAudioFilePlayerItemдля воспроизведения аудиофайла.
    private var asset: WKAudioFileAsset!
    // является вашим наблюдателем ключ-значение для игрокастатус. Вам нужно будет
    // наблюдать застатус принадлежащийигроки начать воспроизведение только в
    // том случае, если аудиофайл готов к воспроизведению.

    private var statusObserver: NSKeyValueObservation?
    // таймеркоторый вы используете для обновления пользовательского интерфейса.
    // Вы запускаете таймер в то же время, когда начинаете играть
    private var timer: Timer!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        let memo = context as! VoiceMemo

        asset = WKAudioFileAsset(url: memo.url)
        titleLabel.setText(memo.filename)
//        playButton.setEnabled(false)
    }

    @IBAction func playButtonTapped() {
        let playerItem = WKAudioFilePlayerItem(asset: asset)
        // 2
        player = WKAudioFilePlayer(playerItem: playerItem)

        player.play()
    }

    override func didAppear() {
        super.didAppear()
//        prepareToPlay()
    }

    private func prepareToPlay() {
        // 1
        let playerItem = WKAudioFilePlayerItem(asset: asset)
        // 2
        player = WKAudioFilePlayer(playerItem: playerItem)
        // 3
        statusObserver = player.observe(
            \.status,
             changeHandler: { [weak self] (player, change) in
                 // 4
                 guard
                    player.status == .readyToPlay,
                    let duration = self?.asset.duration
                 else { return }
                 // 5
                 let date = Date(timeIntervalSinceNow: duration)
                 self?.interfaceTimer.setDate(date)
                 // 6
                 self?.playButton.setEnabled(false)
                 // 7
                 player.play()
                 self?.interfaceTimer.start()
                 // 8
                 self?.timer = Timer.scheduledTimer(
                    withTimeInterval: duration,
                    repeats: false, block: { _ in
                        self?.playButton.setEnabled(true)
                    })
             })
    }
     */
}
