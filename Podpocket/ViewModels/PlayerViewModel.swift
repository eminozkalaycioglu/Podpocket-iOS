//
//  PlayerViewModel.swift
//  Podpocket
//
//  Created by Emin on 22.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class PlayerViewModel: ObservableObject {
    var lastPodcastResult = Podcast()
    @Published private var episodes = [Episode]()
    @Published var loading: Bool = false
    @Published var isFavorited = false
    
    
    @Published var selectedEpisode: Episode = Episode()
    @Published var parentPodcast: ParentPodcast = ParentPodcast()
    var selectedEpisodeId: String = "" {
        didSet {
            self.fetchSelectedEpisode(episodeId: self.selectedEpisodeId)
        }
    }
    
    
    func fetchSelectedEpisode(episodeId: String) {
        self.loading = true
        ServiceManager.shared.fetchEpisodeDetail(id: episodeId) { (result) in
            switch result {
            
            case .success(let response):
                
                self.selectedEpisode = response.convertToEpisodeModel()
                self.parentPodcast = response.podcast
                AudioManager.shared.replaceAudio(audioLinkString: response.audio)
                AudioManager.shared.player?.play()

                self.loading = false
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    func isEpisodeFavorited(episodeId: String) {
        FirebaseConnection.shared.isEpisodeFavorited(episodeId: episodeId) { (favorited) in
            if favorited {
                self.isFavorited = true
            }
            else {
                self.isFavorited = false
            }
        }
    }
    func favorite(episodeId: String, title: String, pubDateMs: Int) {
        FirebaseConnection.shared.addEpisodeToFavoriteList(episodeId: episodeId, title: title, pubDateMs: pubDateMs)
    }
    
    func remove(episodeId: String) {
        FirebaseConnection.shared.removeEpisodeFromFavoriteList(episodeId: episodeId)
    }
    
    func getEpisodes() -> [Episode] {
        return self.episodes
        
    }
    
    func fetchFirstEpisodesList(id: String) {
        self.fetchEpisodes(id: id)
    } // episodes are fetching when player view is loading
    
    
    func fetchMoreEpisode(id: String) {
        
        guard self.lastPodcastResult.nextEpisodePubDate != nil else {
            return
        }
        self.fetchEpisodes(id: id, pubDate: self.lastPodcastResult.nextEpisodePubDate)
        
    } // episodes are fetching when episdes list scrolled
    
    
    func savePodcastToDb(podcastId: String, podcastImage: String) {
        CoreDataManager.shared.savePodcast(podcastId: podcastId, podcastImage: podcastImage)
        
    }
    
    func saveEpisodeToDb(episodeId: String, episodeImage: String) {
        CoreDataManager.shared.saveEpisode(episodeId: episodeId, episodeImage: episodeImage)
        
    }
    
    
}

extension PlayerViewModel {
    private func fetchEpisodes(id: String, pubDate: Int? = nil) {
        
        self.loading = true
        ServiceManager.shared.fetchPodcastDetail(id: id, pubDate: pubDate) { (result) in
            switch result {
            case .success(let response):
                
                self.lastPodcastResult = response
                self.episodes += response.episodes ?? [Episode]()
                
                
                
            case .failure(let error):
                print(error.errorDescription)
            }
            self.loading = false
        }
    }
}
