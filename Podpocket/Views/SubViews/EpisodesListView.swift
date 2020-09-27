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
    @State var presentPlayer = false
    @State var selectedEpisodeId = ""
    
    init(podcast: Podcast) {
        self.viewModel.setPodcast(podcast: podcast)
    }
    var body: some View {
        
        ZStack {
            Color.podpocketPurpleColor
            
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 0, maximum: .infinity))], spacing: 10) {
                        ForEach(self.viewModel.getEpisodes(), id: \.self) { episode in
                            EpisodeCell(episode: episode)
                                .onTapGesture {
                                    self.selectedEpisodeId = episode.id ?? ""
                                    self.presentPlayer = true
                                    
                                }

                        }
                        
                        HStack {
                            Spacer()
                            Image("show")
                                .resizable()
                                .renderingMode(.template).foregroundColor(Color.podpocketGreenColor)
                                .frame(width: 30, height: 30)
                            Text("Show More").foregroundColor(Color.podpocketGreenColor)

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
            
            NavigationLink("", destination: PlayerView(selectedEpisodeId: self.selectedEpisodeId), isActive: self.$presentPlayer)
            
        }
        
    }
    
    
}

//@available(iOS 14.0, *)
//struct EpisodesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//    }
//}
