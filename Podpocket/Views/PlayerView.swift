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
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = PlayerViewModel()
    @State var isPlaying: Bool = true
    @State var isFavorited: Bool = false
    @State var showMoreEpisode: Bool = false
    @State var selectedEpisode = Episode()
    
    var episode: Episode
    var parentPodcastId: String
    var parentPodcastName: String
    init(episode: Episode, parentPodcastId: String, parentPodcastName: String) {
        
        self.episode = episode
        self.parentPodcastId = parentPodcastId
        self.parentPodcastName = parentPodcastName

        AudioManager.initAudio(audioLinkString: self.episode.audio ?? "")
        UINavigationBar.appearance().barTintColor = UIColor.podpocketPurpleColor
    }
    var body: some View {
        
        
        GeometryReader { geometry in

            ZStack {
                Color.podpocketPurpleColor
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {

                    ZStack(alignment: .bottom) {

                        if let url = String.toEncodedURL(link: self.selectedEpisode.image ?? "") {
                            KFImage(url)
                                .resizable()

                                .frame(height: geometry.size.height/2)
                        }

                        if self.showMoreEpisode {
                            ZStack(alignment: .top) {
                                
                                Color.black.opacity(0.5)
                                VStack {
                                    HStack {
                                        Text("ALL EPISODES")
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.podpocketGreenColor)
                                            .padding(5)
                                            .padding(.leading, 20)
                                            .background(Color.gray).opacity(0.7)
                                            .cornerRadius(15)
                                            .offset(x: -15.0, y: 0.0)

                                        Spacer()

                                    }
                                    .padding(.top) // ALL EPISODES
                                    ScrollView(.vertical, showsIndicators: false) {
                                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                                            ForEach(self.viewModel.getEpisodes(), id: \.self) { item in
                                                
                                                HStack {
                                                    Image("playingEpisode")
                                                        .resizable()
                                                        .renderingMode(item.title == self.selectedEpisode.title ? nil : .template)
                                                        .foregroundColor(.gray)
                                                        
                                                        .frame(width: 30, height: 30, alignment: .center)
                                                        
                                                    Text(item.title ?? "")
                                                        .foregroundColor(.white)
                                                    Spacer()
                                                }.padding(.horizontal)
                                                .onAppear {
                                                    if item == self.viewModel.getEpisodes().last {
                                                        self.viewModel.fetchMoreEpisode(id: self.parentPodcastId)
                                                    }
                                                }
                                                .onTapGesture {
                                                    if let audio = item.audio {
                                                        AudioManager.replaceAudio(audioLinkString: audio)
                                                        self.selectedEpisode = item
//                                                        AudioManager.player?.play()
                                                    }
                                                }

                                                
                                                
                                            }
                                        }
                                    }
                                    
                                    
                                }
                                
                                ZStack(alignment: .bottomTrailing) {
                                    VStack {
                                        
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                self.showMoreEpisode.toggle()
                                            }, label: {
                                                Image("showEpisodes")
                                                    .resizable()
                                                    .frame(width: 40, height: 40, alignment: .center)
                                            })
                                        }
                                    }.padding()
                                   
                                } //SHOW MORE EPISODES
                                
                                
                            }
                            .frame(height: geometry.size.height/2)
                            .shadow(radius: 10)
                            
                        }
                        else {
                            VStack {
                                HStack {
                                    Text(self.isPlaying ? "NOW PLAYING" : "PAUSED")
                                        .font(.system(size: 12))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.podpocketGreenColor)
                                        .padding(5)
                                        .padding(.leading, 20)
                                        .background(Color.gray).opacity(0.7)
                                        .cornerRadius(15)
                                        .offset(x: -15.0, y: 0.0)

                                    Spacer()

                                }.padding(.vertical) // Now Playing-Paused
                                HStack {
                                    Image("playingEpisode")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .padding(.leading)
                                    Spacer()
                                    
                                    Text(self.selectedEpisode.title ?? "")
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                        .frame(height: 50)
//
                                    

                                    Spacer()
                                    Button(action: {
                                        if self.viewModel.getEpisodes().count == 0{
                                            self.viewModel.fetchFirstEpisodesList(id: self.parentPodcastId)
                                        }
                                        
                                        self.showMoreEpisode.toggle()
                                    }, label: {
                                        Image("showEpisodes")
                                            .resizable()
                                            .frame(width: 40, height: 40, alignment: .center)
                                    }).padding(.trailing)
                                }
                                
                                self.drawPodcastName()
                                

                            }
                            .background(LinearGradient(gradient: Gradient(colors: [.clear, Color.podpocketPurpleColor.opacity(0.7), Color.podpocketPurpleColor]), startPoint: .top, endPoint: .bottom))
                        }

                    }
                    
                    if self.showMoreEpisode {
                        self.drawPodcastName()
                            .padding(.top)
                    }
                    
                    SliderView()

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
                
                if self.viewModel.loading {
                    CustomProgressView()
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
            self.selectedEpisode = self.episode
            AudioManager.player?.play()
            

        }
        .onDisappear() {
            print("disappear")
//            self.player?.pause()

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
    
    func drawPodcastName() -> AnyView {
        return AnyView(
            HStack {
                Text(self.parentPodcastName)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                Spacer()
            } //Podcast Name
        )
    }
    func favButton() -> AnyView {
        return AnyView(
            Button(action: {
                self.isFavorited.toggle()
            }, label: {
                Image(systemName: self.isFavorited ? "heart.fill" : "heart")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.podpocketGreenColor)

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
                    .foregroundColor(Color.podpocketGreenColor)
                    .frame(width: 25, height: 25, alignment: .center)
            })
        )
    }
}

@available(iOS 14.0, *)
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(episode: Episode(image: "https://cdn-images-1.listennotes.com/podcasts/how-i-built-this/how-i-built-resilience-lognAd_7xj2-2BPVCen5Ip-.300x168.jpg", title: "ASDs sdfasda asdasda asdasdas asda da sdfsfs "), parentPodcastId: "", parentPodcastName: "Podcast")
    }
    
}
