//
//  LastListenedViewModel.swift
//  Podpocket
//
//  Created by Emin on 25.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine
class LastListenedViewModel: ObservableObject {
    
    @Published var lastListenedEpisodes = [LastListenedEpisodes]()
    @Published var lastListenedPodcasts = [LastListenedPodcasts]()
    
    func fetchLastListened() {
        self.fetchLastListenedEpisodes()
        self.fetchLastListenedPodcasts()
    }
    
    func deleteAllRecords() {
        CoreDataManager.shared.deleteAllRecords()
    }
    private func fetchLastListenedPodcasts() {
        CoreDataManager.shared.getLastListenedPodcasts { (podcasts) in
            self.lastListenedPodcasts = podcasts
        }
    }
    private func fetchLastListenedEpisodes() {
        CoreDataManager.shared.getLastListenedEpisodes { (episodes) in
            self.lastListenedEpisodes = episodes
        }
    }
    
}
