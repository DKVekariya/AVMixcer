//
//  PlayerControlViewController.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 23/04/21.
//

import UIKit

protocol PlayerControlDelegate: class {
    func playerControlControlerDidSelectPlayPause(_ controller: PlayerControlViewController)
    func playerControlControlerDidSelectSeek(_ controller: PlayerControlViewController, seek progress:Float)
}

protocol PlayerControlDataSource: class {
    func isPlayerPlaying() -> Bool
    func currentProgress() -> Float
}

class PlayerControlViewController: UIViewController {

    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    weak var delegate: PlayerControlDelegate?
    weak var dataSource: PlayerControlDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButtonState()
        reloadProgress()
        slider.addTarget(self, action: #selector(onSliderSlide(_:)), for: .valueChanged)
        slider.isContinuous = false
    }
    
    func refreshButtonState() {
        playPauseButton.isSelected = dataSource?.isPlayerPlaying() ?? false
    }
    
    func reloadProgress() {
        guard !slider.isTracking else { return }
        slider.setValue(dataSource?.currentProgress() ?? 0, animated: true)
    }
    
    @objc func onSliderSlide(_ sender: UISlider) {
        delegate?.playerControlControlerDidSelectSeek(self, seek: slider.value)
    }
    
    @IBAction func playPause(_ sender: Any) {
        defer {
            refreshButtonState()
        }
        delegate?.playerControlControlerDidSelectPlayPause(self)
    }
}
