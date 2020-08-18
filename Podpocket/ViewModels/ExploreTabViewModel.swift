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
    
    var region: String {
        guard let region = Locale.current.regionCode else {
            return "tr"
        }
        return region.lowercased()
    }
    
    init() {
        self.fetchBestPodcasts()
    }
    
    func fetchBestPodcasts() {
        self.loading = true
        ServiceManager.shared.fetchBestPodcastsInSpecificRegion(region: self.region) { (result) in
            
            switch result {
            case .success(let response):
                self.bestPodcasts = response
                self.loading = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
