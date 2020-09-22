//
//  AudioManager.swift
//  Podpocket
//
//  Created by Emin on 21.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import AVFoundation
class AudioManager {
    
    
    
    static var player : AVPlayer?

    static func initAudio(audioLinkString: String) {
        
        guard let url = URL.init(string: audioLinkString) else { return }
        
        let playerItem = AVPlayerItem.init(url: url)
        AudioManager.player = AVPlayer.init(playerItem: playerItem)
        AudioManager.player?.prepareForInterfaceBuilder()
        
    }
    
    static func replaceAudio(audioLinkString: String) {
        
        guard let url = URL.init(string: audioLinkString) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        AudioManager.player?.replaceCurrentItem(with: playerItem)
        
    }
    
}
