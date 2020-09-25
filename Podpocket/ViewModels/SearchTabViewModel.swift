//
//  SearchTabViewModel.swift
//  Podpocket
//
//  Created by Emin on 28.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class SearchTabViewModel: ObservableObject {
    @Published var selections: [String] = []
    
    @Published var genres: Genres = Genres()
    @Published var podcastResults = [SearchResult]()
    @Published var episodeResult = [SearchResult]()
    
    @Published var loading = false
    var lastPodcastResult = SearchModel()
    var lastEpisodeResult = SearchModel()

    init() {
        self.fetchGenres()
    }
    
    private func fetchGenres() {
        self.loading = true
        ServiceManager.shared.fetchGenres { (result) in
            switch result {
            case .success(let response):
                self.genres = response
                self.loading = false
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }
    
    func searchNextOffset(query: String, type: SearchType) {
        
        var offset: Int = 0
        switch type {
        case .Episode:
            offset = self.lastEpisodeResult.nextOffset ?? 0
            if self.lastEpisodeResult.results?.count == 0 {
                return
            }
        case .Podcast:
            offset = self.lastPodcastResult.nextOffset ?? 0
            if self.lastPodcastResult.results?.count == 0 {
                return
            }
            
        }
        self.loading = true

        ServiceManager.shared.search(query: query, type: type, offset: offset, genres: self.selections.count == 0 ? nil : self.selections) { (result) in
            switch result {
            case .success(let response):
                switch type {
                case .Episode:
                    self.lastEpisodeResult = response
                    self.episodeResult += response.results ?? [SearchResult]()
                case.Podcast:
                    self.lastPodcastResult = response
                    self.podcastResults += response.results ?? [SearchResult]()
                }
                
                self.loading = false
            case .failure(_):

                self.loading = false
            }
        }
    }
    
    func search(query: String, type: SearchType) {
        
        self.loading = true
        
        
        ServiceManager.shared.search(query: query, type: type, offset: 0, genres: self.selections.count == 0 ? nil : self.selections) { (result) in
            switch result {
            case .success(let response):
                switch type {
                case .Episode:
                    self.lastEpisodeResult = response
                    self.episodeResult = response.results ?? [SearchResult]()
                case.Podcast:
                    self.lastPodcastResult = response
                    self.podcastResults = response.results ?? [SearchResult]()
                }
                
                self.loading = false
            case .failure(_):
                self.loading = false
            }
        }
        
        
        
        
    }

    
    
}


