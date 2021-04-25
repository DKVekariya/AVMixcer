//
//  VideoComposer.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 25/04/21.
//

import Foundation
import AVFoundation

class VideoComposer {
    
    func buildComposition() -> AVComposition {
        let composition = AVMutableComposition()
        let track = composition.addMutableTrack(withMediaType: .video, preferredTrackID: 100)
        let audioCompositiontrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: 200)
        
        let url1 = Bundle.main.url(forResource: "video1", withExtension: "mp4")
        let url2 = Bundle.main.url(forResource: "video5", withExtension: "mp4")
        let firstVideo = AVAsset(url: url1!)
        let secondVideo = AVAsset(url: url2!)
        
        if let videoTrackOfFirstVideo = firstVideo.tracks(withMediaType: .video).first, let videoTrackOfSecondVideo = secondVideo.tracks(withMediaType: .video).first, let audioTrackOfFirstVideo = firstVideo.tracks(withMediaType: .audio).first, let audioTrackOfSecondVideo = secondVideo.tracks(withMediaType: .audio).first{
            do {
                
                let firstTrackRange = CMTimeRange(start: .zero, duration: firstVideo.duration)
                let secondTrackRange = CMTimeRange(start: .zero, duration: secondVideo.duration)
                
                try track?.insertTimeRange(firstTrackRange , of: videoTrackOfFirstVideo, at: .zero)
                try track?.insertTimeRange(secondTrackRange, of: videoTrackOfSecondVideo, at: firstTrackRange.end)
                
                //try audioCompositiontrack?.insertTimeRange
                
                try audioCompositiontrack?.insertTimeRange(firstTrackRange, of: audioTrackOfFirstVideo, at: .zero)
                try audioCompositiontrack?.insertTimeRange(secondTrackRange, of: audioTrackOfSecondVideo, at: firstTrackRange.end)
                
            } catch {
                print(error)
            }
        }
        
        return composition
    }
    
    func exportVideo(composition:AVComposition, completion:@escaping (() -> Void)) {
        let exportPath: String = NSTemporaryDirectory().appendingFormat("/video.mp4")
        let exportUrl: URL = URL(fileURLWithPath: exportPath)

        let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
        exporter?.outputURL = exportUrl
        print("out put url\(exporter?.outputURL)")
        exporter?.outputFileType = .mp4

        exporter?.exportAsynchronously(completionHandler: {
            completion()
            print("exporter error\(exporter?.error)")
        })
    }
}
