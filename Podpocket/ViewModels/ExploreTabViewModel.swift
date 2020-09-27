//
//  ExploreTabViewModel.swift
//  Podpocket
//
//  Created by Emin on 18.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class ExploreTabViewModel: ObservableObject {
    @Published var bestPodcasts: PodcastModel?
    @Published var loading: Bool = true
    
    @Published var similarPodcasts: SimilarPodcasts?
    @Published var similarEpisodes: SimilarEpisodes?

    var region: String {
        guard let region = Locale.current.regionCode else {
            return "tr"
        }
        return region.lowercased()
    }
    
    
    
    func fetchBestPodcasts() {
        self.loading = true
        ServiceManager.shared.fetchBestPodcastsInSpecificRegion(region: self.region) { (result) in
            
            switch result {
            case .success(let response):
                self.bestPodcasts = response
                self.fetchSimilarPodcasts()
                self.fetchSimilarEpisodes()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func fetchSimilarPodcasts() {
        self.fetchLastListenedPodcast { (id) in
            ServiceManager.shared.fetchSimilarPodcasts(id: id) { (result) in
                switch result {
                case .success(let response):
                    self.similarPodcasts = response
                    
                case .failure(let error):
                    print(error.errorDescription)
                }
            }
        }
        
    }
    
    func fetchSimilarEpisodes() {
        self.fetchLastListenedEpisode { (id) in
            ServiceManager.shared.fetchSimilarEpisodes(id: id) { (result) in
                switch result {
                case .success(let response):
                    self.similarEpisodes = response
                    self.loading = false

                case .failure(let error):
                    print(error.errorDescription)
                }
            }
        }
    }
    private func fetchLastListenedPodcast(completion: ((String)->())) {
        CoreDataManager.shared.getLastListenedPodcasts { (podcasts) in
            if let podcastId = podcasts.first?.podcastId {
                completion(podcastId)
                return
            }
            else {
                completion((self.bestPodcasts?.podcasts?.first?.id)!)
                return
            }
        }
    }
    
    private func fetchLastListenedEpisode(completion: ((String)->())) {
        CoreDataManager.shared.getLastListenedEpisodes { (episodes) in
            if let episodeId = episodes.first?.episodeId {
                completion(episodeId)
                return
            }
            else {
                completion("6e251fc509744098937af5e7e7e4c263")
                return
            }
        }
    }
}
