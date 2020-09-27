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
    @Published var episodesResult = [Episode]()
    @Published var loading = false
    
    var lastPodcastResult: Podcast = Podcast()

    
    func setPodcast(podcast: Podcast) {
        self.lastPodcastResult = podcast
        self.episodesResult += podcast.episodes ?? [Episode]()
    }
    
    func getEpisodes() -> [Episode] {
        return self.episodesResult
        
    }
    
    func fetchNextEpisodes() {
        self.loading = true
        guard let id = self.lastPodcastResult.id, let nextEpisodePubDate = self.lastPodcastResult.nextEpisodePubDate else {
            return
        }
        ServiceManager.shared.fetchPodcastDetail(id: id, pubDate: nextEpisodePubDate) { (result) in
            switch result {
            case .success(let response):
                self.lastPodcastResult = response
                self.episodesResult += response.episodes ?? [Episode]()
                
            case.failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
}
