//
//  ViewController.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 23/04/21.
//

import UIKit
import AVKit

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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = Bundle.main.url(forResource: "Video2", withExtension: "mp4")
        let item = AVPlayerItem(url: url!)
        
        player.replaceCurrentItem(with: item)
        previewWindow.playerLayer.player = player
        
        
        insert(controlVC, in: controContainer)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidEndPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
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
    func playerControlControlerDidSelectPlayPause(_ controller: PlayerControlViewController) {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
}

extension ViewController: PlayerControlDataSource {
    func isPlayerPlaying() -> Bool {
        player.isPlaying
    }
}
 


