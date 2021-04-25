//
//  AVPlayer+Extension.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 23/04/21.
//

import AVFoundation
import Combine

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

extension AVPlayer {
    var currentDuration:TimeInterval {
        currentItem?.currentTime().seconds ?? 0
    }
    
    var totalDuration:TimeInterval {
        currentItem?.duration.seconds ?? 1
    }
    
    var progress:Float {
        Float(currentDuration/totalDuration)
    }
}

extension AVPlayer {
    var playerObserver: AVPlayerObserver {
        AVPlayerObserver(player: self)
    }
    
    class AVPlayerObserver {
        private let periodicTimeSubject = PassthroughSubject<CMTime, Never>()
        
        var periodicTimeObserver: AnyPublisher<CMTime, Never> {
            periodicTimeSubject.eraseToAnyPublisher()
        }
        
        private var periodicTimeCancellable: Any?
        private weak var player:AVPlayer?
        
        init(player: AVPlayer) {
            self.player = player
            self.periodicTimeCancellable = player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 3), queue: .main) { [weak self] time in
                self?.periodicTimeSubject.send(time)
            }
        }
        
        deinit {
            if let ob = periodicTimeCancellable {
                player?.removeTimeObserver(ob)
            }
        }
    }
}
