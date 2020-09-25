//
//  SearchTabView.swift
//  Podpocket
//
//  Created by Emin on 10.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
@available(iOS 14.0, *)
struct SearchTabView: View {
    @State var query: String = ""
    @State var presentPodcastDetailView: Bool = false
    @State var presentPlayerView: Bool = false
    @StateObject var viewModel = SearchTabViewModel()
    
    
    @State var selectedPodcastId: String = ""
    @State var selectedEpisodeId: String = ""
    
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
                
                VStack(spacing: 0) {
                    HStack {
                        CustomTextField(placeholder: Text("Search an episode, podcast or category").foregroundColor(.gray), text: self.$query)
                            .foregroundColor(.white)
                        Button(action: {
                            
                            self.viewModel.search(query: self.query, type: .Podcast)
                            self.viewModel.search(query: self.query, type: .Episode)
                        }, label: {
                            Image("SearchLogo")
                                .resizable()
                                .frame(width: geometry.size.height / 32, height: geometry.size.height / 32)
                        }).padding(.trailing, 8)
                        
                    }
                    
                    .frame(height: geometry.size.height / 22.3)
                    .padding(.leading, 15)
                    .background(Image("SearchBar").resizable().scaledToFill().frame(height: geometry.size.height / 22.3))
                    
                    .offset(x: -3)
                    .padding(.trailing, 27)
                    .padding(.top, 30)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                            if let data = self.viewModel.genres.genres {
                                
                                ForEach(data, id: \.self) { genre in
                                    GenreCell(genre: genre, isSelected: self.viewModel.selections.contains(genre.id?.description ?? "")) {
                                        if self.viewModel.selections.contains(genre.id?.description ?? "") {
                                            self.viewModel.selections.removeAll(where: { $0 == genre.id?.description })
                                            
                                        }
                                        else {
                                            self.viewModel.selections.append(genre.id?.description ?? "")
                                        }
                                    }
                                }
                                
                            }
                        }.padding()
                    }.frame(height: 60, alignment: .center) //Genres
                    
                    
                    
                    ScrollView {
                        LazyVStack {
                            
                            HStack {
                                Text("PODCASTS")
                                    .foregroundColor(.white)
                                    .font(.title)
                                Spacer()
                            }.padding() //Podcasts Label
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
                                    
                                    
                                    ForEach(self.viewModel.podcastResults, id: \.self) { result in
                                        
                                        SearchResultPodcastCell(podcast: result)
                                            .foregroundColor(.white)
                                            .onAppear {
                                                
                                                if result == self.viewModel.podcastResults.last {
                                                    self.viewModel.searchNextOffset(query: self.query, type: .Podcast)
                                                }
                                            }
                                            .onTapGesture {
                                                self.selectedPodcastId = result.id ?? ""
                                                self.presentPodcastDetailView = true
                                            
                                            }
                                        
                                    }
                                }.padding()
                                .frame(height: self.viewModel.podcastResults.count != 0 ? 180 : 0)
                            } // Podcast Results
                            
                            HStack {
                                Text("EPISODES")
                                    .foregroundColor(.white)
                                    .font(.title)
                                Spacer()
                            }.padding() //Episodes Label
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVGrid(columns: [GridItem(.flexible())], spacing: 50) {
                                    ForEach(self.viewModel.episodeResult, id: \.self) { episode in
                                        
                                        EpisodeCell(episode: Episode(pubDateMs: episode.pubDateMs, title: episode.titleOriginal))
                                            .onTapGesture {
                                                
                                                self.selectedEpisodeId = episode.id ?? ""
                                                self.presentPlayerView = true
                                            }
                                    }
                                }.padding()
                            } // Episodes Results
                            
                            Text("").onAppear {
                                if self.viewModel.episodeResult.count != 0 {
                                    print("last")
                                    self.viewModel.searchNextOffset(query: self.query, type: .Episode)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
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
            
            if self.viewModel.loading {
                CustomProgressView()
            }
        }.navigationBarTitle("").navigationBarHidden(true)
        
    }
    
}


struct SearchTabView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            SearchTabView()
        } else {
            // Fallback on earlier versions
        }
    }
}
