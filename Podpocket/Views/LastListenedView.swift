//
//  LastListenedView.swift
//  Podpocket
//
//  Created by Emin on 25.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

@available(iOS 14.0, *)
struct LastListenedView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = LastListenedViewModel()
    
    @State var presentPlayerView: Bool = false
    @State var selectedEpisodeId = ""
    
    @State var presentPodcastDetailView: Bool = false
    @State var selectedPodcastId = ""
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.podpocketPurpleColor
        
    }
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
                        self.backButton()
                        Spacer()
                        
                    } // Back button
                    .padding()
                    
                    HStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: geometry.size.height / 15, height: geometry.size.height / 15)
                        Text("Podpocket")
                            .foregroundColor(.white)
                        Spacer()
                    } // Logo & Clean Button
                    .padding(.horizontal)
                    
                    
                    ScrollView {
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            
                            
                            HStack {
                                Text("PODCASTS")
                                    .foregroundColor(.white)
                                    .font(.title)
                                
                                Button(action: {
                                    self.viewModel.deleteAllRecords()
                                    self.viewModel.fetchLastListened()
                                }, label: {
                                    HStack {
                                        Text("Clean")
                                            .foregroundColor(Color.podpocketGreenColor)
                                        
                                        Image("secret")
                                            .resizable()
                                            
                                            .renderingMode(.template)
                                            .foregroundColor(Color.podpocketGreenColor)
                                            .frame(width: 30, height: 30)
                                    }
                                })
                                .padding(.leading)
                                Spacer()
                            } // Podcasts Title
                            .padding()
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: [GridItem(.flexible())]) {
                                    ForEach(self.viewModel.lastListenedPodcasts, id: \.self) { podcast in
                                        
                                        VStack(alignment: .center) {
                                            if let url = String.toEncodedURL(link: podcast.podcastImage ?? "") {
                                                KFImage(url)
                                                    .resizable()
                                                    .frame(width: 150, height: 150)
                                                    .cornerRadius(10)
                                            }
                                            Text(podcast.podcastTitle ?? "")
                                                .foregroundColor(.white)
                                                .frame(maxWidth: 140,minHeight: 25)
                                                .font(.system(size: 15))
                                                .multilineTextAlignment(.center)
                                        }.onTapGesture {
                                            if let id = podcast.podcastId {
                                                self.selectedPodcastId = id
                                                self.presentPodcastDetailView = true
                                            }
                                            
                                        }
                                    }
                                    
                                }
                                .frame(height: self.viewModel.lastListenedPodcasts.count != 0 ? 200 : 0)
                                .padding(.horizontal)
                                
                            } // Podcasts
                            
                            Section(header:
                                        HStack {
                                            Text("EPISODES")
                                                .foregroundColor(.white)
                                                .font(.title)
                                            Spacer()
                                        } // Episodes Title
                                        .padding()
                                        .background(Color.podpocketPurpleColor)
                                            
                            ) {
                                ScrollView(.vertical) {
                                    
                                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                                        
                                        ForEach(self.viewModel.lastListenedEpisodes, id: \.self) { episode in
                                            HStack(alignment: .top) {
                                                
                                                if let url = String.toEncodedURL(link: episode.episodeImage ?? "") {
                                                    KFImage(url)
                                                        .resizable()
                                                        .frame(width: 150, height: 150)
                                                }
                                                
                                                Text(episode.episodeTitle ?? "")
                                                    .foregroundColor(.white)
                                                    .padding(.top)
                                                Spacer()
                                                
                                                
                                                
                                            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.podpocketGreenColor.opacity(0.7), lineWidth: 0.5))
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                                            .onTapGesture {
                                                if let id = episode.episodeId {
                                                    self.selectedEpisodeId = id
                                                    self.presentPlayerView = true
                                                }
                                            }
                                        }
                                    }
                                    
                                } // Episodes
                            }
                            
                            Spacer()
                            
                        }
                    }
                }
                
                NavigationLink(
                    destination: PlayerView(selectedEpisodeId: self.selectedEpisodeId),
                    isActive: self.$presentPlayerView,
                    label: {
                        Text("")
                    })
                
                NavigationLink(
                    destination: PodcastDetailView(id: self.selectedPodcastId),
                    isActive: self.$presentPodcastDetailView,
                    label: {
                        Text("")
                    })
            }.onAppear {
                self.viewModel.fetchLastListened()
            }
            
        }.navigationBarBackButtonHidden(true)
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarHidden(true)
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
struct LastListenedView_Previews: PreviewProvider {
    static var previews: some View {
        LastListenedView()
    }
}
