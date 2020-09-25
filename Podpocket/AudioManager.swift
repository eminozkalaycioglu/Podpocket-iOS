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
    
    private init() {
        
    }
    
    static let shared = AudioManager()
    
    var player : AVPlayer?

    func initAudio(audioLinkString: String) {
        
        guard let url = URL.init(string: audioLinkString) else {
            AudioManager.shared.player = AVPlayer(playerItem: nil)
            return }
        
        let playerItem = AVPlayerItem.init(url: url)
        AudioManager.shared.player = AVPlayer.init(playerItem: playerItem)
        AudioManager.shared.player?.prepareForInterfaceBuilder()
        
    }
    
    func replaceAudio(audioLinkString: String) {
        
        guard let url = URL.init(string: audioLinkString) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        AudioManager.shared.player?.replaceCurrentItem(with: playerItem)
        
    }
    
}
