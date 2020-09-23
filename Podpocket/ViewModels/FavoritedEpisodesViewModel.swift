//
//  FavoritedEpisodesViewModel.swift
//  Podpocket
//
//  Created by Emin on 23.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class FavoritedEpisodesViewModel: ObservableObject {
    @Published var favoritedEpisodes = [FavoritedEpisodeModel]()
    @Published var presentPlayerView: Bool = false
    
    var selectedFavoritedEpisode = Episode()
    var parentPodcastId: String = ""
    var parentPodcastName: String = ""
    init() {
        self.fetchAllFavoritedEpisodes()
        
    }
    func fetchAllFavoritedEpisodes() {
        FirebaseConnection.shared.fetchAllFavoritedEpisodes { (favoritedEpisodes) in
            self.favoritedEpisodes = favoritedEpisodes
        }
    }
    
    func fetchFavoritedEpisodeDetail(id: String) {
        ServiceManager.shared.fetchEpisodeDetail(id: id) { (result) in
            switch result {
            case .success(let response):
                
                self.selectedFavoritedEpisode = Episode(audio: response.audio, descriptionField: response.descriptionField, id: response.id, image: response.image, pubDateMs: response.pubDateMs, title: response.title)
                self.parentPodcastId = response.podcast.id
                self.parentPodcastName = response.podcast.title
                self.presentPlayerView = true
                print("")
            case .failure(let error):
                print(error.errorDescription)
                
            }
            
        }
    }
}
