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
    @Published var numberOfFavorites = 0
    
    
    @Published var selectedEpisode: Episode = Episode() {
        didSet {
            self.fetchNumberOfFavorites()
            self.observeFavorite()

        }
    }
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
    
    func observeFavorite() {
        FirebaseConnection.shared.observeFavorites(episodeId: self.selectedEpisode.id ?? "") { (changed) in
            if changed {
                self.fetchNumberOfFavorites()
            }
        }
    }
    
    func fetchNumberOfFavorites() {
        FirebaseConnection.shared.fetchNumberOfFavorites(episodeId: self.selectedEpisode.id ?? "") { (numberOfFavorites) in
            self.numberOfFavorites = numberOfFavorites
            
        }
    }
    
    func isEpisodeFavorited() {
        FirebaseConnection.shared.isEpisodeFavorited(episodeId: self.selectedEpisode.id ?? "") { (favorited) in
            if favorited {
                self.isFavorited = true
            }
            else {
                self.isFavorited = false
            }
        }
    }
    func favorite() {
        let episode = self.selectedEpisode
        FirebaseConnection.shared.addEpisodeToFavoriteList(episodeId: episode.id ?? "", title: episode.title ?? "", pubDateMs: episode.pubDateMs ?? 0)
    }
    
    func removeFromFavoritedList() {
        FirebaseConnection.shared.removeEpisodeFromFavoriteList(episodeId: self.selectedEpisode.id ?? "")
    }
    
    func getEpisodes() -> [Episode] {
        return self.episodes
        
    }
    
    func fetchFirstEpisodesList(podcastId: String) {
        self.fetchOtherEpisodes(podcastId: podcastId)
    } // episodes are fetching when player view is loading
    
    
    func fetchMoreEpisode(podcastId: String) {
        
        guard self.lastPodcastResult.nextEpisodePubDate != nil else {
            return
        }
        self.fetchOtherEpisodes(podcastId: podcastId, pubDate: self.lastPodcastResult.nextEpisodePubDate)
        
    } // episodes are fetching when episdes list scrolled
    
    
    func savePodcastToDb(podcastId: String, podcastImage: String, podcastTitle: String) {
        CoreDataManager.shared.savePodcast(podcastId: podcastId, podcastImage: podcastImage, podcastTitle: podcastTitle)
        
    }
    
    func saveEpisodeToDb(episodeId: String, episodeImage: String, episodeTitle: String) {
        CoreDataManager.shared.saveEpisode(episodeId: episodeId, episodeImage: episodeImage, episodeTitle: episodeTitle)
        
    }
    
    
}

extension PlayerViewModel {
    private func fetchOtherEpisodes(podcastId: String, pubDate: Int? = nil) {
        
        self.loading = true
        ServiceManager.shared.fetchPodcastDetail(id: podcastId, pubDate: pubDate) { (result) in
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
