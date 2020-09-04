//
//  EpisodesListViewModel.swift
//  Podpocket
//
//  Created by Emin on 4.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class EpisodesListViewModel: ObservableObject {
    @Published var podcast: Podcast = Podcast()
    
    func setPodcast(podcast: Podcast) {
        self.podcast = podcast
    }
    
    func getEpisodes() -> [Episode] {
        return self.podcast.episodes ?? [Episode]()
    }
    
}
