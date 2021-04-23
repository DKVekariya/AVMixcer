//
//  PlayerControlViewController.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 23/04/21.
//

import UIKit

protocol PlayerControlDelegate: class {
    func playerControlControlerDidSelectPlayPause(_ controller: PlayerControlViewController)
}

protocol PlayerControlDataSource: class {
    func isPlayerPlaying() -> Bool
}

class PlayerControlViewController: UIViewController {

    @IBOutlet weak var playPauseButton: UIButton!
    
    weak var delegate: PlayerControlDelegate?
    weak var dataSource: PlayerControlDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButtonState()
    }
    
    func refreshButtonState() {
        playPauseButton.isSelected = dataSource?.isPlayerPlaying() ?? false
    }
    
    @IBAction func playPause(_ sender: Any) {
        defer {
            refreshButtonState()
        }
        delegate?.playerControlControlerDidSelectPlayPause(self)
    }
}
