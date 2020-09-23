//
//  SliderView.swift
//  Podpocket
//
//  Created by Emin on 22.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import AVFoundation


struct SliderView: View {
    
    @State var seekPos: Double = 0.0
    @State var totalTime = "00:00"
    @State var currentTime = "00:00"
    @State var isSliding = false
    var body: some View {
        
        VStack(spacing: 0) {
            
            Slider(value: self.$seekPos, in: 0...1) { (editing) in
                self.isSliding = editing
               
                guard let item = AudioManager.player?.currentItem else {
                    return
                }
                let targetTime = self.seekPos * item.duration.seconds
                
                AudioManager.player?.seek(to: CMTime(seconds: targetTime, preferredTimescale: 600))
            }.accentColor(Color.podpocketGreenColor)
            .padding(.top)
            .padding(.horizontal)
            
            .onAppear {
                
                AudioManager.player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { time in
                    guard let item = AudioManager.player?.currentItem, !(item.duration.seconds.isNaN || item.duration.seconds.isInfinite) else {
                        self.seekPos = 0.0
                        
                      return
                    }

                    
                    if !(self.isSliding) {
                        self.seekPos = time.seconds / item.duration.seconds

                    }
                    self.totalTime = self.secondsToHoursMinutesSeconds(seconds: Int(item.duration.seconds))

                    self.currentTime = self.secondsToHoursMinutesSeconds(seconds: Int(time.seconds))
                }
            }
            HStack {
                Text(self.currentTime)
                    .foregroundColor(.gray)
                Spacer()
                Text(self.totalTime)
                    .foregroundColor(.gray)
            }.padding(.horizontal)
        }
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        let hoursString = hours < 10 ? "0\(hours)" : hours.description
        let minutesString = minutes < 10 ? "0\(minutes)" : minutes.description
        let secondsString = seconds < 10 ? "0\(seconds)" : seconds.description
        
        if hours == 0 {
            return "\(minutesString):\(secondsString)"
        }
        else {
            return "\(hoursString):\(minutesString):\(secondsString)"
        }
      
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
