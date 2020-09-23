//
//  FavoritedEpisodes.swift
//  Podpocket
//
//  Created by Emin on 23.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct FavoritedEpisodes: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var viewModel = FavoritedEpisodesViewModel()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.podpocketPurpleColor
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Spacer()
                        Image("search2")
                            .resizable()
                            .frame(width: geometry.size.height / 22.3, height: geometry.size.height / 22.3)
                            
                            .hidden()
                            .overlay(
                                
                                Image("dmm")
                                    .resizable()
                                    .frame(width: geometry.size.height / 2.5, height: geometry.size.height / 2.5)
                                
                            )
                            .padding(.trailing, 30)
                            .padding(.top, 30)
                        
                    }
                    Spacer()
                }
                
                VStack {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: geometry.size.height / 15, height: geometry.size.height / 15)
                        Text("Podpocket")
                            .foregroundColor(.white)
                        Spacer()
                    }.padding()
                    .padding(.top)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("YOUR FAVORITED EPISODES")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.bottom, 5)
                            Text("All your favourited\nepisodes under one roof!")
                                .font(.system(size: 15))
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            
                        }.padding()
                        Spacer()
                    }
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            ForEach(self.viewModel.favoritedEpisodes, id: \.id) { episode in
                                EpisodeCell(episode: Episode(id: episode.episodeId,pubDateMs: episode.pubDateMs, title: episode.title))
                                    .onTapGesture {
                                        self.viewModel.fetchFavoritedEpisodeDetail(id: episode.episodeId)
                                    }
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                NavigationLink(
                    destination: PlayerView(episode: self.viewModel.selectedFavoritedEpisode, parentPodcastId: self.viewModel.parentPodcastId, parentPodcastName: self.viewModel.parentPodcastName),
                    isActive: self.$viewModel.presentPlayerView,
                    label: {
                        Text("")
                    })
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("",displayMode: .inline)
            .navigationBarItems(leading: self.backButton())
            
        }
        
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
struct FavoritedEpisodes_Previews: PreviewProvider {
    static var previews: some View {
        FavoritedEpisodes()
    }
}
