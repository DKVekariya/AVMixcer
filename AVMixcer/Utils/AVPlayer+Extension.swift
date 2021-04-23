//
//  AVPlayer+Extension.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 23/04/21.
//

import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
