//
//  EpisodesListView.swift
//  Podpocket
//
//  Created by Emin on 4.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct EpisodesListView: View {
    @ObservedObject var viewModel: EpisodesListViewModel = EpisodesListViewModel()
    
    init(podcast: Podcast) {
        self.viewModel.setPodcast(podcast: podcast)

    }
    var body: some View {
        
        ZStack {
            Color.init(hex: Color.podpocketPurpleColor)
            
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 0, maximum: .infinity))], spacing: 10) {
                        ForEach(self.viewModel.getEpisodes(), id: \.self) { episode in
                            EpisodeCell(episode: episode)

                        }
                        
                        HStack {
                            Spacer()
                            Image("show")
                                .resizable()
                                .renderingMode(.template).foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                                .frame(width: 30, height: 30)
                            Text("Show More").foregroundColor(Color.init(hex: Color.podpocketGreenColor))

                            Spacer()
                        }
                        .padding()
                        .onTapGesture {
                            self.viewModel.fetchNextEpisodes()
                        }
                        
                        
                    }
                }
                Spacer()
            }
            
        }
        
    }
    
    static func dummyEpisodes() -> [Episode] {
        var episodes = [Episode]()
        episodes.removeAll()
        for item in 1...6 {
            let episode = Episode(pubDateMs: 123354363235, title: "Episode Title \(item)")
            episodes.append(episode)
        }
        return episodes
        
    }
}

@available(iOS 14.0, *)
struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView(podcast: Podcast(episodes: EpisodesListView.dummyEpisodes()))
    }
}
