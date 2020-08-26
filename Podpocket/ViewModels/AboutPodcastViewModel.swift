//
//  AboutPodcastViewModel.swift
//  Podpocket
//
//  Created by Emin on 26.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class AboutPodcastViewModel: ObservableObject {
    @Published var similarPodcasts: SimilarPodcasts = SimilarPodcasts()
    @Published var loading: Bool = false
    
    var rootPodcast: Podcast = Podcast() {
        didSet {
            if self.rootPodcast.id != nil {
                print("fetchingsimilar")
                self.fetchSimilarPodcasts()

            }
        }
    }
    
    func setRootPodcast(podcast: Podcast) {
        self.rootPodcast = podcast
    }
    
    func fetchSimilarPodcasts() {
        self.loading = true
        ServiceManager.shared.fetchSimilarPodcasts(id: self.rootPodcast.id ?? "") { (result) in
            switch result {
            case .success(let response):
                self.similarPodcasts = response

                self.loading = false
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }


}
