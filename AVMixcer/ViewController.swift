//
//  ViewController.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 23/04/21.
//

import UIKit
import AVKit
import MediaPlayer
import Combine

class ViewController: UIViewController {
    
    let player = AVPlayer()
    @IBOutlet weak var previewWindow: AVPlayerView!
    @IBOutlet weak var controContainer: UIView!
    
    lazy var controlVC: PlayerControlViewController = {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let controlVC = storyboard.instantiateViewController(identifier: "controlController") as! PlayerControlViewController
        controlVC.delegate = self
        controlVC.dataSource = self
        return controlVC
    }()
    
    var cancellables = Set<AnyCancellable>()
    var playerOb:AVPlayer.AVPlayerObserver?
    var composer = VideoComposer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        insert(controlVC, in: controContainer)
        
        player.replaceCurrentItem(with: composer.buildPlayerItem())
        previewWindow.playerLayer.player = player
        player.seek(to: CMTime.init(seconds: 40, preferredTimescale: 1))
//        composer.exportVideo(composition: composer.buildComposition()) {
//            print("export complete")
//        }
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidEndPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            
        self.playerOb = player.playerObserver
        playerOb?.periodicTimeObserver.sink(receiveValue: { [weak self] _ in
            self?.controlVC.reloadProgress()
        }).store(in: &cancellables)
        
        player.volume = 0.2
    }
    
    @objc func playerDidEndPlaying(_ n:Notification) {
        DispatchQueue.main.async {
            if let item = n.object as? AVPlayerItem, item == self.player.currentItem {
                self.player.pause()
                self.player.seek(to: CMTime.zero)
                self.controlVC.refreshButtonState()
            }
        }
    }
    
}

extension ViewController: PlayerControlDelegate {
    func playerControlControlerDidSelectSeek(_ controller: PlayerControlViewController, seek progress: Float) {
        player.seek(to: CMTime(seconds: player.totalDuration * TimeInterval(progress), preferredTimescale: 600))
    }
    
    func playerControlControlerDidSelectPlayPause(_ controller: PlayerControlViewController) {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
}

extension ViewController: PlayerControlDataSource {
    func currentProgress() -> Float {
        player.progress
    }
    
    func isPlayerPlaying() -> Bool {
        player.isPlaying
    }
}
