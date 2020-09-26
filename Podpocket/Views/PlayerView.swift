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
    @State var showMoreEpisode: Bool = false
    
    var selectedEpisodeId: String
    init(selectedEpisodeId: String) {
        self.selectedEpisodeId = selectedEpisodeId
        AudioManager.shared.initAudio(audioLinkString: "")
        UINavigationBar.appearance().barTintColor = UIColor.podpocketPurpleColor
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Color.podpocketPurpleColor
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    ZStack(alignment: .bottom) {
                        if let url = String.toEncodedURL(link: self.viewModel.selectedEpisode.image ?? "") {
                            KFImage(url)
                                .resizable()
                                .frame(height: geometry.size.height/(1.5))
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
                                                        .renderingMode(item.title == self.viewModel.selectedEpisode.title ? nil : .template)
                                                        .foregroundColor(.gray)
                                                        
                                                        .frame(width: 30, height: 30, alignment: .center)
                                                        
                                                    Text(item.title ?? "")
                                                        .foregroundColor(.white)
                                                    Spacer()
                                                }.padding(.horizontal)
                                                .onAppear {
                                                    if item == self.viewModel.getEpisodes().last {
                                                        self.viewModel.fetchMoreEpisode(podcastId: self.viewModel.parentPodcast.id ?? "")
                                                    }
                                                }
                                                .onTapGesture {
                                                    if let audio = item.audio {
                                                        AudioManager.shared.replaceAudio(audioLinkString: audio)
                                                        self.viewModel.selectedEpisode = item
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
                                                Image("hideEpisodes")
                                                    .resizable()
                                                    .frame(width: 40, height: 40, alignment: .center)
                                            })
                                        }
                                    }.padding()
                                   
                                } //SHOW MORE EPISODES
                                
                            }
                            .frame(height: geometry.size.height/(1.5))
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
                                    
                                    HStack(spacing: 0) {
                                        Image(systemName: "heart.fill")
                                            .renderingMode(.template)
                                            .foregroundColor(Color.podpocketGreenColor)
                                            .padding(.leading, 5)
                                        Text(": \(self.viewModel.numberOfFavorites)")
                                            .font(.system(size: 12))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.podpocketGreenColor)
                                            
                                    }.padding(.trailing, 20)
                                    .padding(.vertical, 5)
                                    .background(Color.gray).opacity(0.7)
                                    .cornerRadius(15)
                                    .offset(x: 15.0, y: 0.0)
                                    

                                }.padding(.vertical) // Now Playing-Paused
                                HStack {
                                    Image("playingEpisode")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .padding(.leading)
                                    Spacer()
                                    
                                    Text(self.viewModel.selectedEpisode.title ?? "")
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                        .frame(height: 50)
                              
                                    Spacer()
                                    Button(action: {
                                        
                                        self.showMoreEpisode.toggle()
                                    }, label: {
                                        Image("showEpisodes")
                                            .resizable()
                                            .frame(width: 40, height: 40, alignment: .center)
                                    }).padding(.trailing)
                                }
                                
                                self.drawPodcastName()
                                    .padding(.leading)
                                
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
                            for episode in self.viewModel.getEpisodes() {
                                if episode.id == self.viewModel.selectedEpisode.id && episode != self.viewModel.getEpisodes().first {
                                    
                                    let currentIndex = self.viewModel.getEpisodes().firstIndex(of: episode)!
                                    let previousEpisode = self.viewModel.getEpisodes()[currentIndex - 1]
                                    AudioManager.shared.replaceAudio(audioLinkString: previousEpisode.audio ?? "")
                                    self.viewModel.selectedEpisode = previousEpisode
                                    break
                                }
                            }

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
                            
                            for episode in self.viewModel.getEpisodes() {
                                if episode.id == self.viewModel.selectedEpisode.id {
                                    
                                    if episode != self.viewModel.getEpisodes().last {
                                        let currentIndex = self.viewModel.getEpisodes().firstIndex(of: episode)!
                                        let nextEpisode = self.viewModel.getEpisodes()[currentIndex + 1]
                                        AudioManager.shared.replaceAudio(audioLinkString: nextEpisode.audio ?? "")
                                        self.viewModel.selectedEpisode = nextEpisode
                                        break
                                    }
                                    
                                }
                            }
                            
                            
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
            self.viewModel.selectedEpisodeId = self.selectedEpisodeId
        }
        .onReceive(self.viewModel.$parentPodcast, perform: { podcast in
            if self.viewModel.getEpisodes().count == 0 {
                self.viewModel.fetchFirstEpisodesList(podcastId: podcast.id ?? "")
            }
            
            self.viewModel.savePodcastToDb(podcastId: podcast.id ?? "", podcastImage: podcast.image ?? "", podcastTitle: podcast.title ?? "")
            
        })
        .onChange(of: self.viewModel.selectedEpisode, perform: { value in
            self.viewModel.isEpisodeFavorited()
            
            self.viewModel.saveEpisodeToDb(episodeId: self.viewModel.selectedEpisode.id ?? "", episodeImage: self.viewModel.selectedEpisode.image ?? "", episodeTitle: self.viewModel.selectedEpisode.title ?? "")
        })
       
    }
    
    func manageAudio() {
        self.isPlaying.toggle()
        if !self.isPlaying {
            AudioManager.shared.player?.pause()
        } else {
            AudioManager.shared.player?.play()
        }
    }
    
    func drawPodcastName() -> AnyView {
        return AnyView(
            HStack {
                Text(self.viewModel.parentPodcast.title ?? "")
                    .foregroundColor(.gray)
                    .lineLimit(1)
                Spacer()
            } //Podcast Name
        )
    }
    func favButton() -> AnyView {
        return AnyView(
            Button(action: {

                if self.viewModel.isFavorited {
                    self.viewModel.removeFromFavoritedList()
                }
                else {
                    self.viewModel.favorite()

                }
                self.viewModel.isFavorited.toggle()
                self.viewModel.fetchNumberOfFavorites()
            }, label: {
                Image(systemName: self.viewModel.isFavorited ? "heart.fill" : "heart")
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
        PlayerView(selectedEpisodeId: "bc51a3b5aefe43a08f4b78d55e629164")
    }

}
