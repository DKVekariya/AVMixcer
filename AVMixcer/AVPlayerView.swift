//
//  AVPlayerView.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 23/04/21.
//

import AVKit

class AVPlayerView: UIView {
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer:AVPlayerLayer {
        self.layer as! AVPlayerLayer
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        self.backgroundColor = .green
    }
}
