//
//  PlayerView.swift
//  Podpocket
//
//  Created by Emin on 19.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import AVFoundation
import struct Kingfisher.KFImage


@available(iOS 14.0, *)
struct PlayerView: View {

    @State var isPlaying: Bool = true
    @State var isFavorited: Bool = false
    @State private var seekPos = 0.0
    @State var totalTime = ""
    @State var currentTime = ""
    @State var isSliding = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    

    var episode: Episode
    var parentPodcastId: String
    
    init(episode: Episode, parentPodcastId: String) {
        
        self.episode = episode
        self.parentPodcastId = parentPodcastId
        
        AudioManager.initAudio(audioLinkString: self.episode.audio ?? "")
        
            
        UINavigationBar.appearance().barTintColor = UIColor().hexStringToUIColor(hex: Color.podpocketPurpleColor)
    }
    var body: some View {
        
        
        GeometryReader { geometry in

            ZStack {
                Color.init(hex: Color.podpocketPurpleColor)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {

                    ZStack(alignment: .top) {
                        ZStack(alignment: .bottom) {

                            if let url = String.toEncodedURL(link: self.episode.image ?? "") {
                                KFImage(url)
                                    .resizable()

                                    .frame(height: geometry.size.height/2)
                            }


                            VStack {

                                HStack {
                                    Text(self.isPlaying ? "NOW PLAYING" : "PAUSED")
                                        .font(.system(size: 12))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                                        .padding(5)
                                        .padding(.leading, 20)
                                        .background(Color.gray).opacity(0.7)
                                        .cornerRadius(15)
                                        .offset(x: -15.0, y: 0.0)

                                    Spacer()

                                }.padding(.vertical)
                                HStack {
                                    Image("playingEpisode")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .padding(.leading)
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        MarqueeText(text: self.episode.title ?? "")
                                            .foregroundColor(.white)
                                    }



                                    .frame(width: 230, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))




                                    Spacer()
                                    Button(action: {

                                    }, label: {
                                        Image("showEpisodes").resizable().frame(width: 40, height: 40, alignment: .center)
                                    }).padding(.trailing)
                                }
                                HStack {
                                    Text("Podcast Name").foregroundColor(.gray)
                                    Spacer()
                                }

                            }
                            .background(LinearGradient(gradient: Gradient(colors: [.clear,Color.init(hex: Color.podpocketPurpleColor).opacity(0.7), Color.init(hex: Color.podpocketPurpleColor)]), startPoint: .top, endPoint: .bottom))

                        }


                    }
                    Slider(value: self.$seekPos, in: 0...1) { (_) in
                        self.isSliding = true
                        guard let item = AudioManager.player?.currentItem else {
                          return
                        }
                        let targetTime = self.seekPos * item.duration.seconds
                          AudioManager.player?.seek(to: CMTime(seconds: targetTime, preferredTimescale: 600))
                        self.isSliding = false
                    }.padding(.top)
                    .padding(.horizontal)
                    HStack {
                        Text(self.currentTime)
                        Spacer()
                        Text(self.totalTime)
                    }.padding(.horizontal)
                    HStack {
                        Button(action: {

                        }, label: {
                            Image("previousEpisode")

                        }).padding(.trailing)

                        Button(action: {
                            withAnimation {
    
                                self.manageAudio()
                                
                            }
                        }, label: {
                            Image(self.isPlaying ? "pauseButton" : "playButton")
                                    .resizable()
                                    .frame(width: 60, height: 60, alignment: .center)

                        })
                        Button(action: {

                        }, label: {
                            Image("nextEpisode")


                        }).padding(.leading)

                    }.padding(.top, 30)
                    
                    
                    

                    Spacer()
                }
            }

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarItems(
            leading:
                HStack {
                    self.backButton()
                    Image("Logo")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(UIScreen.main.bounds.size.width/4+30)

                    
                },
            trailing: self.favButton()
        )
        .onAppear() {
            AudioManager.player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { time in
                guard let item = AudioManager.player?.currentItem, !(item.duration.seconds.isNaN || item.duration.seconds.isInfinite) else {
                  return
                }

                print("\(time.seconds) \n \(item.duration.seconds)")
                if !self.isSliding {
                    self.seekPos = time.seconds / item.duration.seconds

                }
                
                self.totalTime = self.secondsToHoursMinutesSeconds(seconds: Int(item.duration.seconds))

                self.currentTime = self.secondsToHoursMinutesSeconds(seconds: Int(time.seconds))
            }
            
            AudioManager.player?.play()

        }
        .onDisappear() {
            print("disappear")
//            self.player?.pause()
            
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
    
    func manageAudio() {
        self.isPlaying.toggle()
        if !self.isPlaying {
            AudioManager.player?.pause()
        } else {
            AudioManager.player?.play()
        }
    }
    func favButton() -> AnyView {
        return AnyView(
            Button(action: {
                self.isFavorited.toggle()
            }, label: {
                Image(systemName: self.isFavorited ? "heart.fill" : "heart")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                    
                    .frame(width: 22, height: 20, alignment: .center)

            })
        )
    }
    
    func backButton() -> AnyView {
        return AnyView(
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("back")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                    .frame(width: 25, height: 25, alignment: .center)
            })
        )
    }
}

@available(iOS 14.0, *)
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(episode: Episode(image: "https://cdn-images-1.listennotes.com/podcasts/how-i-built-this/how-i-built-resilience-lognAd_7xj2-2BPVCen5Ip-.300x168.jpg", title: "ASDs sdfasda asdasda asdasdas asda da sdfsfs "), parentPodcastId: "")
    }
    
}
